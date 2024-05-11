import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';
import 'package:hydrobud/widget/list_view_pages/analytics_page.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateData extends StatefulWidget {
  final AnalyticsData data;
  const UpdateData({super.key, required this.data});

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  List<String> items = ['Crop 1', 'Crop 2', 'Crop 3'];
  String? selectedItems;
  DateTime? transplantDate;
  DateTime? harvestedDate;
  String hintText = "Select Crops...";
  String totalPlantedCrops = "";
  String totalKGs = "";
  String salesAmount = "";

  final supabase = Supabase.instance.client;

  // Setting controllers for text field for initial values
  TextEditingController totalPlantedController = TextEditingController();
  TextEditingController totalKGsController = TextEditingController();
  TextEditingController salesAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItems = widget.data.cropName;
    transplantDate = _formatDate(widget.data.transplantDate);
    harvestedDate = _formatDate(widget.data.harvestDate);
    totalPlantedController.text = widget.data.totalHarvest.toString();
    totalKGsController.text = widget.data.totalWeight.toString();
    salesAmountController.text = widget.data.totalSales.toString();
  }

  @override
  void dispose() {
    totalPlantedController.dispose();
    totalKGsController.dispose();
    salesAmountController.dispose();
    super.dispose();
  }

  DateTime _formatDate(String dateString) {
    final DateFormat originalFormat = DateFormat('MMMM dd, yyyy');
    final DateTime parsedDate = originalFormat.parse(dateString);
    return parsedDate;
  }

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
          ),
        ),
        child: child!,
      ),
    );
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
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != harvestedDate) {
      setState(() {
        harvestedDate = picked;
      });
    }
  }

  void logDataSubmit() {
    if (selectedItems == null ||
        transplantDate == null ||
        harvestedDate == null ||
        totalPlantedCrops.isEmpty ||
        totalKGs.isEmpty ||
        salesAmount.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fields Empty'),
            content: const Text(
              'Please fill in all fields.',
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    } else {
      _sendDataToSupabase();
      Fluttertoast.showToast(
          msg: "Data successfully logged",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
    }
  }

  Future<void> _sendDataToSupabase() async {
    try {
      final response = await supabase.from('log_data').update({
        'crop_name': selectedItems,
        'transplant_date': DateFormat.yMMMMd('en_US').format(transplantDate!),
        'harvest_date': DateFormat.yMMMMd('en_US').format(harvestedDate!),
        'total_crops': totalPlantedCrops,
        'total_weight': totalKGs,
        'total_sales': salesAmount,
      }).eq('id', widget.data.id);

      if (response.error != null) {
        debugPrint('Error updating data: ${response.error!.message}');
      } else {
        debugPrint('Data updated successfully');
      }
    } catch (error) {
      debugPrint('Error updating data: $error');
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
          'Update Logged Data',
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
                  const Text(
                    "Crop name",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
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
                          const SizedBox(), // or underline: Container(), to remove the underline
                      hint: Text(
                        hintText,
                        style: const TextStyle(fontSize: 20),
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
                      const Text(
                        "Transplant Date",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        transplantDate != null
                            ? "${transplantDate!.day}/${transplantDate!.month}/${transplantDate!.year}"
                            : "Select Date",
                        style: const TextStyle(fontSize: 16),
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
                      const Text(
                        "Date Harvested",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        harvestedDate != null
                            ? "${harvestedDate!.day}/${harvestedDate!.month}/${harvestedDate!.year}"
                            : "Select Date",
                        style: const TextStyle(fontSize: 16),
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
                  controller: totalPlantedController,
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
                  controller: totalKGsController,
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
                  controller: salesAmountController,
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
          backgroundColor: Colors.green,
          child: const Icon(Icons.check),
          onPressed: () {
            logDataSubmit();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
