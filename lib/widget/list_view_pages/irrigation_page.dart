import 'package:flutter/material.dart';

class IrrigationPage extends StatefulWidget {
  const IrrigationPage({super.key});

  @override
  _IrrigationPageState createState() => _IrrigationPageState();
}

class _IrrigationPageState extends State<IrrigationPage> {
  List<String> crops = ['Crop 1', 'Crop 2', 'Crop 3'];
  String? selectedCrops;

  List<String> nutSol = ['Kiss Nutrients', 'NutriHydro'];
  String? selectedNutSol;

  String hintText = "Select Crops...";
  String hintText2 = "Select NutSol...";

  String numberOfCrops = '';
  String litersOfWater = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Irrigation',
          style: TextStyle(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Crop name",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: Text(
                              hintText,
                              style: const TextStyle(fontSize: 16),
                            ),
                            value: selectedCrops,
                            items: [
                              ...crops.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              })
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCrops = newValue;
                                hintText = newValue ?? "Select Crops...";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Nutrients",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: Text(
                              hintText2,
                              style: const TextStyle(fontSize: 16),
                            ),
                            value: selectedNutSol,
                            items: [
                              ...nutSol.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              })
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedNutSol = newValue;
                                hintText2 = newValue ?? "Select Nutrients...";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Number of crops',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white70,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            onChanged: (value) {
                              setState(() {
                                numberOfCrops = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Liters of water',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white70,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            onChanged: (value) {
                              setState(() {
                                litersOfWater = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            // Add your action here
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 26, vertical: 17),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow),
              SizedBox(width: 8),
              Text(
                'Start',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
