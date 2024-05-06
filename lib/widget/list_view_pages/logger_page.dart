import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';

class LoggerPage extends StatefulWidget {
  const LoggerPage({super.key});

  @override
  _LoggerPageState createState() => _LoggerPageState();
}

class _LoggerPageState extends State<LoggerPage> {
  List<String> items = ['Crop 1', 'Crop 2', 'Crop 3'];
  String? selectedItems;
  DateTime? transplantDate;
  DateTime? harvestedDate;
  String hintText = "Select Crops...";
  String totalPlantedCrops = "";
  String totalKGs = "";
  String salesAmount = "";

  Future<void> _selectTransplantDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: const ColorScheme.dark(
                primary: onPrimaryColor,
              )),
              child: child!,
            ));
    if (picked != null && picked != transplantDate) {
      setState(() {
        transplantDate = picked;
      });
    }
  }

  Future<void> _selectHarvestedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: const ColorScheme.dark(
                primary: onPrimaryColor,
              )),
              child: child!,
            ));
    if (picked != null && picked != harvestedDate) {
      setState(() {
        harvestedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Crop name",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                      height: 5), // Add some space between label and dropdown
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline:
                          SizedBox(), // or underline: Container(), to remove the underline
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
                              style: const TextStyle(fontSize: 20),
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
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => _selectTransplantDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transplant Date",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        transplantDate != null
                            ? "${transplantDate!.day}/${transplantDate!.month}/${transplantDate!.year}"
                            : "Select Date",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectHarvestedDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date Harvested",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        harvestedDate != null
                            ? "${harvestedDate!.day}/${harvestedDate!.month}/${harvestedDate!.year}"
                            : "Select Date",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Total Planted Crops", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white70,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      totalPlantedCrops = textvalue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text("Total Weight (KG)", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white70,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (textvalue) {
                    setState(() {
                      totalKGs = textvalue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text("Sales Amount (PHP)", style: TextStyle(fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white70,
                  decoration: const InputDecoration(border: InputBorder.none),
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
            // CODE FOR PRESSED
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.check),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
