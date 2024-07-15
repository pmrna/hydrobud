import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/logger_banner_title.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/logger_input_field.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/text_label.dart';
import 'package:hydrobud/features/navigation/presentation/pages/wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class HistoryLoggerPage extends StatefulWidget {
  final int id;
  const HistoryLoggerPage({super.key, required this.id});

  @override
  State<HistoryLoggerPage> createState() => _HistoryLoggerPageState();
}

class _HistoryLoggerPageState extends State<HistoryLoggerPage> {
  final _numberOfHarvestController = TextEditingController();
  final _totalWeightController = TextEditingController();
  final _totalSalesController = TextEditingController();
  final _numberOfTransplantController = TextEditingController();

  String _transplantDateDisplay = '';
  String _harvestDateDisplay = '';
  String _cropNameDisplay = '';

  @override
  void initState() {
    super.initState();
    _setValuesFromDB();
  }

  Future<void> _updateData() async {
    final supabase = Supabase.instance.client;

    await supabase.from('log_data').update({
      'total_harvests': _numberOfHarvestController.text,
      'total_weight': _totalWeightController.text,
      'total_sales': _totalSalesController.text,
      'transplanted_crops': _numberOfTransplantController.text,
    }).eq('id', widget.id);

    if (mounted) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Wrapper()),
        );
      });
    }
  }

  Future<void> _setValuesFromDB() async {
    final supabase = Supabase.instance.client;
    final logData =
        await supabase.from('log_data').select().eq('id', widget.id);

    final transplantDate = DateTime.parse(logData[0]['transplant_date']);
    final harvestDate = DateTime.parse(logData[0]['harvest_date']);
    final cropName = logData[0]['crop_name'];
    final numberOfHarvests = logData[0]['total_harvests'];
    final totalWeight = logData[0]['total_weight'];
    final totalSales = logData[0]['total_sales'];
    final numberOfTransplants = logData[0]['transplanted_crops'];

    if (mounted) {
      setState(() {
        _transplantDateDisplay =
            DateFormat.yMMMMd('en_US').format(transplantDate).toString();
        _harvestDateDisplay =
            DateFormat.yMMMMd('en_US').format(harvestDate).toString();
        _cropNameDisplay = cropName;
        _numberOfHarvestController.text = numberOfHarvests.toString();
        _totalWeightController.text = totalWeight.toString();
        _totalSalesController.text = totalSales.toString();
        _numberOfTransplantController.text = numberOfTransplants.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const HeaderText(text: 'Logger'),
          const SizedBox(height: 30),
          const Row(
            children: [
              TextLabel(
                text: 'Transplant Date',
                size: 14,
                color: AppPallete.textColorGray,
              ),
              Spacer(flex: 1),
              TextLabel(
                text: 'Harvest Date',
                size: 14,
                color: AppPallete.textColorGray,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              TextLabel(
                text: _transplantDateDisplay,
                size: 20,
                color: AppPallete.textColorBlack,
              ),
              const Spacer(flex: 1),
              TextLabel(
                text: _harvestDateDisplay,
                size: 20,
                color: AppPallete.textColorBlack,
              ),
            ],
          ),
          const SizedBox(height: 35),
          LoggerBannerTitle(
            cropName: _cropNameDisplay,
            id: widget.id,
          ),
          const SizedBox(height: 30),
          const TextLabel(text: 'Total number of harvest', size: 16),
          LoggerInputField(
            hintText: 'Total number of harvested crops',
            controller: _numberOfHarvestController,
          ),
          const SizedBox(height: 25),
          const TextLabel(text: 'Total weight of harvest (kg)', size: 16),
          LoggerInputField(
            hintText: 'Total weight of harvested crops',
            controller: _totalWeightController,
          ),
          const SizedBox(height: 25),
          const TextLabel(
              text: 'Total amount of sales for this harvest (₱)', size: 16),
          LoggerInputField(
            hintText: 'Total sales for this harvest',
            controller: _totalSalesController,
          ),
          const SizedBox(height: 25),
          const TextLabel(text: 'Number of transplanted crops', size: 16),
          LoggerInputField(
            hintText: 'Total number of harvested crops',
            controller: _numberOfTransplantController,
          ),
          const SizedBox(height: 150), // for scrolling, change value later,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateData,
        backgroundColor: AppPallete.foregroundColor,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
