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
      body: Center(
        child: SizedBox(
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
              }).toList(),
            ],
            onChanged: (String? newValue) {
              setState(() {
                selectedItems = newValue;
              });
            },
          ),
        ),
      ),
    );
  }
}