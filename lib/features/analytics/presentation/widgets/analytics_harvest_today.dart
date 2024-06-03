import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class AnalyticsHarvestTodayGraph extends StatelessWidget {
  const AnalyticsHarvestTodayGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 215,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        border: Border.all(
          color: WidgetPallete.greenStroke,
          width: 5.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Number of\nharvest made',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 15.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: ColoredBox(
                    color: Colors.grey.shade600,
                  ),
                ),
                Container(
                  width: 50, // Adjust the multiplier to scale the bar width
                  height: 15.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: WidgetPallete.greenAccent1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: const ColoredBox(
                    color: WidgetPallete.greenAccent1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              '50 of 100',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
