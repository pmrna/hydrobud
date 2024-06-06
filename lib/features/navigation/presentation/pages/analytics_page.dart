import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/analytics_graph_container.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/analytics_harvest_today.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/analytics_total_graph.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppPallete.foregroundColor,
        child: const Icon(
          Icons.filter_alt,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
        child: ListView(
          children: const [
            HeaderText(text: 'Analytics'),
            SizedBox(height: 10),
            AnalyticsGraphContainer(),
            SizedBox(height: 25),
            Row(
              children: [
                AnalyticsTotalGraph(),
                SizedBox(width: 10),
                AnalyticsHarvestTodayGraph(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
