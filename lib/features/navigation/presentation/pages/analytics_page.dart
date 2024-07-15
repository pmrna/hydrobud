import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/analytics_graph_container.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/analytics_container_capacity.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/analytics_total_graph.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: const [
        SizedBox(height: 20),
        HeaderText(text: 'Analytics'),
        SizedBox(height: 30),
        AnalyticsGraphContainer(),
        SizedBox(height: 20),
        AnalyticsCapacityGraph(),
        SizedBox(height: 20),
        Row(children: [AnalyticsTotalGraph()]),
        SizedBox(height: 120),
      ],
    );
  }
}
