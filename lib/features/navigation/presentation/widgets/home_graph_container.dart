import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/graph/presentation/widgets/bar_chart.dart';

class HomeGraphContainer extends StatelessWidget {
  const HomeGraphContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 346,
      height: 335,
      decoration: BoxDecoration(
        color: WidgetPallete.graphContainerColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(1, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Water qualities',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorBlack,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      'Tracking realtime',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorBlack.withOpacity(0.5),
                        letterSpacing: -0.25,
                      ),
                    ),
                    // const Spacer(flex: ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 220,
            child: Scaffold(
              body: SingleBarChartWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
