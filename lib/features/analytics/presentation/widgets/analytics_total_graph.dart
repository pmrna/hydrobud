import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/total_label_text.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/total_value_text.dart';

class AnalyticsTotalGraph extends StatelessWidget {
  const AnalyticsTotalGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 215,
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
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const TotalValueText(text: '₱5,000'),
            const TotalLabelText(text: 'Total Sales Made'),
            const TotalValueText(text: '1,261'),
            const TotalLabelText(text: 'Total Harvest'),
            const TotalValueText(text: '30kg'),
            const TotalLabelText(text: 'Total Weight of Harvest'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    'As of today',
                    style: TextStyle(
                      color: AppPallete.textColorBlack.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
