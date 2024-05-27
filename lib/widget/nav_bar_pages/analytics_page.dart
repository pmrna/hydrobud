import 'package:flutter/material.dart';
import 'package:hydrobud/widget/analytics_chart/analytics_chart.dart';

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
          SizedBox(height: 35),
          SizedBox(height: 35),
          Expanded(child: AnalyticsPageChart()),
        ],
      ),
      // rest of codes here
    );
  }
}
