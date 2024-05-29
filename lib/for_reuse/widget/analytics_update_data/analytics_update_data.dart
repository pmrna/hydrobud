import 'package:flutter/material.dart';
import 'package:hydrobud/features/navigation/presentation/pages/history_page.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrobud/constants/colors.dart';

class UpdateData extends StatefulWidget {
  final HistoryData data;
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

  TextEditingController totalPlantedController = TextEditingController();
  TextEditingController totalKGsController = TextEditingController();
  TextEditingController salesAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItems = widget.data.cropName;
    transplantDate = _formatDate(widget.data.transplantDate);
    harvestedDate = _formatDate(widget.data.harvestDate);
    totalPlantedController.text = widget.data.totalCrops;
    totalKGsController.text = widget.data.totalWeight;
    salesAmountController.text = widget.data.totalSales;
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

  Future<void> _selectDate(BuildContext context, DateTime? initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
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
    if (picked != null && picked != initialDate) {
      setState(() {
        if (initialDate == transplantDate) {
          transplantDate = picked;
        } else {
          harvestedDate = picked;
        }
      });
    }
  }

  Widget _buildDateField(String label, DateTime? date) {
    return GestureDetector(
      onTap: () => _selectDate(context, date),
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
              label,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              date != null
                  ? "${date.month}/${date.day}/${date.year}"
                  : "Select Date",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void logDataSubmit() {
    setState(() {
      totalPlantedCrops = totalPlantedController.text;
      totalKGs = totalKGsController.text;
      salesAmount = salesAmountController.text;
    });
    if (selectedItems == null ||
        transplantDate == null ||
        harvestedDate == null ||
        totalPlantedCrops.isEmpty ||
        totalKGs.isEmpty ||
        salesAmount.isEmpty) {
      _showDialog();
    } else {
      _sendDataToSupabase();
      _showToast("Data successfully updated");
      Navigator.of(context).pop();
    }
  }

  void _showDialog() {
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
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _sendDataToSupabase() async {
    try {
      await supabase.from('log_data').update({
        'crop_name': selectedItems,
        'transplant_date': DateFormat.yMMMMd('en_US').format(transplantDate!),
        'harvest_date': DateFormat.yMMMMd('en_US').format(harvestedDate!),
        'total_crops': totalPlantedCrops,
        'total_weight': totalKGs,
        'total_sales': salesAmount,
      }).eq('id', widget.data.id);
    } catch (error) {
      debugPrint('Error updating data: $error');
    }
  }

  Widget _buildDropdown() {
    return Column(
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
              style: const TextStyle(fontSize: 20),
            ),
            value: selectedItems,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedItems = newValue;
                hintText = newValue ?? "Select Crops...";
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            cursorColor: Colors.white70,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
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
              _buildDropdown(),
              const SizedBox(height: 30),
              _buildDateField("Transplant Date", transplantDate),
              const SizedBox(height: 10),
              _buildDateField("Date Harvested", harvestedDate),
              const SizedBox(height: 30),
              _buildTextField("Total Planted Crops", totalPlantedController),
              const SizedBox(height: 10),
              _buildTextField("Total Weight (KG)", totalKGsController),
              const SizedBox(height: 10),
              _buildTextField("Sales Amount (PHP)", salesAmountController),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: logDataSubmit,
          child: const Icon(Icons.check),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
