import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/total_label_text.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/total_value_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsTotalGraph extends StatefulWidget {
  const AnalyticsTotalGraph({super.key});

  @override
  State<AnalyticsTotalGraph> createState() => _AnalyticsTotalGraphState();
}

class _AnalyticsTotalGraphState extends State<AnalyticsTotalGraph> {
  List<Map<String, dynamic>> data = [];
  double totalSales = 0;
  double totalHarvests = 0;
  double totalWeight = 0;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('log_data')
        .select('total_sales, total_harvests, total_weight');

    final data = response as List<dynamic>;

    if (mounted) {
      setState(() {
        this.data = data.map((item) => item as Map<String, dynamic>).toList();
        totalSales = data.fold(
            0,
            (sum, item) =>
                sum +
                (item['total_sales'] is String
                    ? double.tryParse(item['total_sales']) ?? 0
                    : item['total_sales']));
        totalHarvests = data.fold(
            0,
            (sum, item) =>
                sum +
                (item['total_harvests'] is String
                    ? double.tryParse(item['total_harvests']) ?? 0
                    : item['total_harvests']));
        totalWeight = data.fold(
            0,
            (sum, item) =>
                sum +
                (item['total_weight'] is String
                    ? double.tryParse(item['total_weight']) ?? 0
                    : item['total_weight']));
      });
    }

    debugPrint(data.toString());
    debugPrint('total sales: $totalWeight');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 220,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            WidgetPallete.greenGradient1,
            WidgetPallete.greenGradient2,
            WidgetPallete.greenGradient2,
          ],
          transform: GradientRotation(4.70),
          stops: [
            0.0,
            0.25,
            0.89,
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TotalValueText(text: '₱$totalSales'),
            const TotalLabelText(text: 'Total Sales Made'),
            TotalValueText(text: '$totalHarvests'),
            const TotalLabelText(text: 'Total Harvest'),
            TotalValueText(text: '${totalWeight}kg'),
            const TotalLabelText(text: 'Total Weight of Harvest'),
            const SizedBox(height: 5),
            Text(
              'As of today',
              style: TextStyle(
                color: AppPallete.textColorBlack.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
            )
          ],
        ),
      ),
    );
  }
}
