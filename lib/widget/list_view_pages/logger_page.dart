import 'package:flutter/material.dart';

class LoggerPage extends StatefulWidget {
  const LoggerPage({Key? key}) : super(key: key);

  @override
  _LoggerPageState createState() => _LoggerPageState();
}

class _LoggerPageState extends State<LoggerPage> {
  List<String> items = ['Crop 1', 'Crop 2', 'Crop 3'];
  String? selectedItems;
  String hintText = "Select Crops...";
  String transplantDate = "";
  String dateHarvested = "";
  String totalPlantedCrops = "";
  String totalKGs = "";
  String salesAmount = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Logger',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    hintText,
                    style: TextStyle(fontSize: 20),
                  ),
                  value: selectedItems,
                  items: [
                    ...items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    })
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItems = newValue;
                      hintText = newValue ?? "Select Crops...";
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Text("Transplant Date", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      transplantDate = textvalue;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text("Date Harvested", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      dateHarvested = textvalue;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text("Total Planted Crops", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      totalPlantedCrops = textvalue;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text("Total KGs", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      totalKGs = textvalue;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text("Sales Amount", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      salesAmount = textvalue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {
            // CODE FOR
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.check),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
