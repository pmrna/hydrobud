import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class AnalyticsCapacityGraph extends StatefulWidget {
  const AnalyticsCapacityGraph({super.key});

  @override
  State<AnalyticsCapacityGraph> createState() => _AnalyticsCapacityGraphState();
}

class _AnalyticsCapacityGraphState extends State<AnalyticsCapacityGraph> {
  @override
  void initState() {
    super.initState();
  }

  static const double totalCapacity = 500;

  final List<Map<String, dynamic>> data = [
    {'label': 'Solution A', 'value': 130},
    {'label': 'Solution B', 'value': 320},
    {'label': 'pH Up', 'value': 440},
    {'label': 'pH Down', 'value': 50},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          color: WidgetPallete.greenStroke,
          width: 5.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Container Capacity',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.sublist(0, 2).map((entry) {
                    return _CapacityItem(
                      label: entry['label'] as String,
                      value: entry['value'] as int,
                      totalCapacity: totalCapacity,
                    );
                  }).toList(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.sublist(2, 4).map((entry) {
                    return _CapacityItem(
                      label: entry['label'] as String,
                      value: entry['value'] as int,
                      totalCapacity: totalCapacity,
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CapacityItem extends StatelessWidget {
  final String label;
  final int value;
  final double totalCapacity;

  const _CapacityItem({
    required this.label,
    required this.value,
    required this.totalCapacity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                height: 16.0,
                width: 130.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              Container(
                height: 16.0,
                width: value / totalCapacity * 130.0,
                decoration: BoxDecoration(
                  color: WidgetPallete.greenAccent1,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '$value mL of $totalCapacity mL',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
