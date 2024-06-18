import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/logger_banner_title.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/logger_input_field.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/text_label.dart';
import 'package:hydrobud/features/navigation/presentation/pages/wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class LoggerPage extends StatefulWidget {
  const LoggerPage({super.key});

  @override
  State<LoggerPage> createState() => _LoggerPageState();
}

class _LoggerPageState extends State<LoggerPage> {
  final numberOfHarvestController = TextEditingController();
  final totalWeightController = TextEditingController();
  final totalSalesController = TextEditingController();
  final numberOfTransplantController = TextEditingController();

  final Map<String, dynamic> _irrigationPreset = {};

  int _harvestId = 0;

  String _transplantDateDisplay = '';
  String _harvestDateDisplay = '';
  String _cropNameDisplay = '';

  @override
  void initState() {
    super.initState();
    _setValuesFromDB();
  }

  Future<void> _insertData() async {
    final supabase = Supabase.instance.client;

    await supabase.from('log_data').insert({
      'total_harvests': numberOfHarvestController.text,
      'total_weight': totalWeightController.text,
      'total_sales': totalSalesController.text,
      'transplanted_crops': numberOfTransplantController.text,
      'transplant_date': _irrigationPreset['transplant_date'],
      'harvest_date': _irrigationPreset['harvest_date'],
      'crop_name': _irrigationPreset['crop_name'],
      'status': true,
    });

    await supabase
        .from('irrigation_presets')
        .update({'is_ongoing': false}).eq('id', 1);

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
    final irrigationData = await supabase
        .from('irrigation_presets')
        .select('transplant_date, harvest_date, crop_name');

    final logData = await supabase.from('log_data').count(CountOption.exact);

    debugPrint(logData.toString());

    final transplantDate = DateTime.parse(irrigationData[0]['transplant_date']);
    final harvestDate = DateTime.parse(irrigationData[0]['harvest_date']);
    final cropName = irrigationData[0]['crop_name'];

    _irrigationPreset['transplant_date'] = transplantDate.toString();
    _irrigationPreset['harvest_date'] = harvestDate.toString();
    _irrigationPreset['crop_name'] = cropName.toString();

    if (mounted) {
      setState(() {
        _transplantDateDisplay =
            DateFormat.yMMMMd('en_US').format(transplantDate).toString();
        _harvestDateDisplay =
            DateFormat.yMMMMd('en_US').format(harvestDate).toString();

        _cropNameDisplay = cropName;

        _harvestId = logData + 1;
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
            id: _harvestId,
          ),
          const SizedBox(height: 30),
          const TextLabel(text: 'Total number of harvest', size: 16),
          LoggerInputField(
            hintText: 'Total number of harvested crops',
            controller: numberOfHarvestController,
          ),
          const SizedBox(height: 25),
          const TextLabel(text: 'Total weight of harvest (kg)', size: 16),
          LoggerInputField(
            hintText: 'Total weight of harvested crops',
            controller: totalWeightController,
          ),
          const SizedBox(height: 25),
          const TextLabel(
              text: 'Total amount of sales for this harvest (₱)', size: 16),
          LoggerInputField(
            hintText: 'Total sales for this harvest',
            controller: totalSalesController,
          ),
          const SizedBox(height: 25),
          const TextLabel(text: 'Number of transplanted crops', size: 16),
          LoggerInputField(
            hintText: 'Total number of harvested crops',
            controller: numberOfTransplantController,
          ),
          const SizedBox(height: 150), // for scrolling, change value later,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insertData,
        backgroundColor: AppPallete.foregroundColor,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
