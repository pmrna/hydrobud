import 'package:flutter/material.dart';
import 'package:hydrobud/for_reuse/widget/analytics_chart/analytics_chart.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: AnalyticsPageChart()),
        ],
      ),
      // rest of codes here
    );
  }
}
