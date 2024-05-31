import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/navigation/presentation/widgets/graph_outlined_button.dart';

class AnalyticsGraphContainer extends StatelessWidget {
  const AnalyticsGraphContainer({super.key});

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
              vertical: 5.0,
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
                      'Last 12 hours',
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
                const Row(
                  children: [
                    Text(
                      'PH',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorBlack,
                        letterSpacing: -0.25,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '5.5',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorGreen2,
                        letterSpacing: -2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 207,
            child: Scaffold(
              body: Center(child: Text('Graph')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GraphOutlinedButton(
                  onTap: () {},
                  text: 'PH',
                  borderColor: WidgetPallete.greenStroke,
                ),
                GraphOutlinedButton(
                  onTap: () {},
                  text: 'PPM',
                  borderColor: WidgetPallete.yellowstroke,
                ),
                GraphOutlinedButton(
                  onTap: () {},
                  text: 'TEMP',
                  borderColor: WidgetPallete.pinkStroke,
                ),
                GraphOutlinedButton(
                  onTap: () {},
                  text: 'LEVEL',
                  borderColor: WidgetPallete.blueStroke,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
