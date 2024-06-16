import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/logger_banner_title.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/logger_input_field.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/text_label.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  void initState() {
    super.initState();
  }

  Future<void> _insertData() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('log_data').insert({
      'total_harvests': numberOfHarvestController.text,
      'total_weight': totalWeightController.text,
      'total_sales': totalSalesController.text,
      'transplanted_crops': numberOfTransplantController.text
    });

    if (response != null) {
      print('Data inserted successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _insertData,
        backgroundColor: AppPallete.foregroundColor,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 20),
          const Center(child: HeaderText(text: 'Logger')),
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
          const Row(
            children: [
              TextLabel(
                text: 'April 20, 2024',
                size: 20,
                color: AppPallete.textColorBlack,
              ),
              Spacer(flex: 1),
              TextLabel(
                text: 'May 19, 2024',
                size: 20,
                color: AppPallete.textColorBlack,
              ),
            ],
          ),
          const SizedBox(height: 35),
          const BannerTitle(),
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
    );
  }
}
