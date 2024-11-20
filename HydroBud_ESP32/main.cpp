#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

// TDS SENSOR LIBRARY
//#include "CQRobotTDS.h"

// TEMP SENSOR LIBRARY
#include <OneWire.h>
#include <DallasTemperature.h>

#define WIFI_SSID "TEST SERVER"
#define WIFI_PASSWORD "223501070090"
#define API_KEY "" // DB API_KEY
#define DATABASE_URL "" 

// TEMPERATURE SENSOR
#define ONE_WIRE_BUS 32
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
float Celsius = 0;

// TDS SENSOR
#define TdsSensorPin 35
#define VREF 5.0 // analog reference voltage(Volt) of the ADC
#define SCOUNT 30 // sum of sample point
int analogBuffer[SCOUNT]; // store the analog value in the array, read from ADC
int analogBufferTemp[SCOUNT];
int analogBufferIndex = 0, copyIndex = 0;
float averageVoltage = 0, tdsValue = 0, temperature = 25;

int getMedianNum(int bArray[], int iFilterLen) 
{
  int bTab[iFilterLen];
  for (byte i = 0; i < iFilterLen; i++)
    bTab[i] = bArray[i];
  int i, j, bTemp;
  for (j = 0; j < iFilterLen - 1; j++) 
  {
    for (i = 0; i < iFilterLen - j - 1; i++) 
    {
      if (bTab[i] > bTab[i + 1]) 
      {
        bTemp = bTab[i];
        bTab[i] = bTab[i + 1];
        bTab[i + 1] = bTemp;
      }
    }
  }
  if ((iFilterLen & 1) > 0)
    bTemp = bTab[(iFilterLen - 1) / 2];
  else
    bTemp = (bTab[iFilterLen / 2] + bTab[iFilterLen / 2 - 1]) / 2;
  return bTemp;
}


// PH SENSOR
unsigned long int avgValue;  // Store the average value of the sensor feedback
float b;
int buf[10], inet;

#define pHsens 36
#define led1 2
#define periPump1 4
#define PWMChannel 0
#define EchoPin 25
#define TrigPin 33

const int freq = 5000;
const int resolution = 8;

FirebaseData fbdo, fbdo_s1, fbdo_s2; // s = stream, 1 stream for each node path
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
bool signupOK = false;
int pwmValue = 0;
bool ledStatus = false;
bool mixStatus = false;

void setup() {
  Serial.begin(115200);

  //TEMP SENSOR INITIALIZE
  sensors.begin();
  //TDS PIN
  pinMode(TdsSensorPin, INPUT);

  pinMode(led1, OUTPUT);
  pinMode(periPump1, OUTPUT);

  pinMode(EchoPin, INPUT_PULLUP);
  pinMode(TrigPin, OUTPUT);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("Sign Up OK");
    signupOK = true;
  } else {
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  config.token_status_callback = tokenStatusCallback;
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  if (!Firebase.RTDB.beginStream(&fbdo_s1, "ESP32/irrigation/mix/"))
    Serial.printf("Stream 1 error, %s\n\n", fbdo_s1.errorReason().c_str());
  if (!Firebase.RTDB.beginStream(&fbdo_s2, "ESP32/LED/digital/"))
    Serial.printf("Stream 2 error, %s\n\n", fbdo_s2.errorReason().c_str());
}

void loop() {
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 7000 || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    // TDS SENSOR READING
    static unsigned long analogSampleTimepoint = millis();
    if (millis() - analogSampleTimepoint > 40U) // every 40 milliseconds, read the analog value from the ADC
    { 
      analogSampleTimepoint = millis();
      analogBuffer[analogBufferIndex] = analogRead(TdsSensorPin); // read the analog value and store into the buffer
      analogBufferIndex++;
      if (analogBufferIndex == SCOUNT)
        analogBufferIndex = 0;
    }
    static unsigned long printTimepoint = millis();
    if (millis() - printTimepoint > 800U) 
    {
      printTimepoint = millis();
    
      for (copyIndex = 0; copyIndex < SCOUNT; copyIndex++)
        analogBufferTemp[copyIndex] = analogBuffer[copyIndex];
      averageVoltage = getMedianNum(analogBufferTemp, SCOUNT) * (float)VREF / 1024.0; // read the analog value more stable by the median filtering algorithm, and convert to voltage value
      float compensationCoefficient = 1.0 + 0.02 * (temperature - 25.0); // temperature compensation formula: fFinalResult(25^C) = fFinalResult(current)/(1.0+0.02*(fTP-25.0));
      float compensationVolatge = averageVoltage / compensationCoefficient; // temperature compensation
      tdsValue = (133.42 * compensationVolatge * compensationVolatge * compensationVolatge - 255.86 * compensationVolatge * compensationVolatge + 857.39 * compensationVolatge) * 0.5; // convert voltage value to tds value
      //Serial.print("TDS Value:");
      //Serial.print(tdsValue, 0);
      //Serial.println("ppm");
    }

    // PH SENSOR READING
    for (int i = 0; i < 10; i++) 
    { // Get 10 sample values from the sensor for smoothing the value
      buf[i] = analogRead(pHsens);
      delay(10);
    }
    for (int i = 0; i < 9; i++) // Sort the analog values from small to large
    { 
      for (int j = i + 1; j < 10; j++) 
      {
        if (buf[i] > buf[j]) {
          inet = buf[i];
          buf[i] = buf[j];
          buf[j] = inet;
        }
      }
    }
    avgValue = 0;
    for (int i = 2; i < 8; i++) // Take the average value of 6 center samples
    { 
      avgValue += buf[i];
    }

    float phValue = (float)avgValue * 5 / 4096 / 9; // Convert the analog value into millivolt
    phValue = 3.1 * phValue;

    // TEMPERATURE READING
    sensors.requestTemperatures();

    Celsius = sensors.getTempCByIndex(0);
    delay(1000);

    // ULTRASONIC SENSOR READING
    digitalWrite(TrigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(TrigPin, HIGH);
    delayMicroseconds(15);
    int duration = pulseIn(EchoPin, HIGH, 40000); // Adjust the timeout value as needed
    int distance = duration / 58; // Convert the duration to distance in cm

    // ------------------------------------- PH METER ------------------------------------- //
    if (Firebase.RTDB.setFloat(&fbdo, "ESP32/Sensor/pH Level", phValue)) 
    {
      Serial.println();
      Serial.print(phValue);
      Serial.print(" - Successfully saved to: " + fbdo.dataPath());
      Serial.print(" (" + fbdo.dataType() + ")");
    } 
    else 
    {
      Serial.println("Failed: " + fbdo.errorReason());
    }

    // ------------------------------------- TDS SENSOR ------------------------------------- //
    if (Firebase.RTDB.setFloat(&fbdo, "ESP32/Sensor/TDS Value", tdsValue)) 
    {
      Serial.println();
      //Serial.print("TDS value: ");
      Serial.print(tdsValue, 2);
      Serial.print(" ppm");
      Serial.print(" - Successfully saved to: " + fbdo.dataPath());
      Serial.print(" (" + fbdo.dataType() + ")");
    } 
    else 
    {
      Serial.println("Failed: " + fbdo.errorReason());
    }

    // ------------------------------------- TEMPERATURE ------------------------------------- //
    if (Firebase.RTDB.setFloat(&fbdo, "ESP32/Sensor/Temperature", Celsius)) 
    {
      Serial.println();
      Serial.print(Celsius);
      Serial.print(" C  ");
      Serial.print(" - Successfully saved to: " + fbdo.dataPath());
      Serial.print(" (" + fbdo.dataType() + ")");
    } 
    else 
    {
      Serial.println("Failed: " + fbdo.errorReason());
    }

    // ------------------------------------- ULTRASONIC ------------------------------------- //
    if (Firebase.RTDB.setInt(&fbdo, "ESP32/Sensor/Water-Level", distance)) 
    {
      Serial.println();
      Serial.print(distance);
      Serial.print(" cm");
      Serial.print(" - Successfully saved to: " + fbdo.dataPath());
      Serial.println(" (" + fbdo.dataType() + ")");
    } 
    else 
    {
      Serial.println("Failed: " + fbdo.errorReason());
    }
  }
  // ------------------------------------------------------DATA READING FIREBASE --------------------------------------------------------- //
  if (Firebase.ready() && signupOK) 
  {
    if (!Firebase.RTDB.readStream(&fbdo_s1))
      Serial.printf("stream 1 read error, %s\n\n", fbdo_s1.errorReason().c_str());

    if (fbdo_s1.streamAvailable()) 
    {
      if (fbdo_s1.dataType() == "boolean") 
      {
        mixStatus = fbdo_s1.boolData();
        Serial.println();
        Serial.println("Successful READ from " + fbdo_s1.dataPath() + ": " + mixStatus + " (" + fbdo_s1.dataType() + ") ");
        digitalWrite(periPump1, !mixStatus);
      }
    }

    if (!Firebase.RTDB.readStream(&fbdo_s2))
      Serial.printf("stream 2 read error, %s\n\n", fbdo_s2.errorReason().c_str());

    if (fbdo_s2.streamAvailable()) 
    {
      if (fbdo_s2.dataType() == "boolean") 
      {
        ledStatus = fbdo_s2.boolData();
        Serial.println("Successful READ from " + fbdo_s2.dataPath() + ": " + ledStatus + " (" + fbdo_s2.dataType() + ") ");
        digitalWrite(led1, ledStatus);
      }
    }
  }
}
