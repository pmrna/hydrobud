import 'package:flutter/material.dart';
import 'package:hydrobud/widget/loading_indicator/loading_indicator.dart';
import 'package:hydrobud/widget/ph_line_chart/ph_line_chart_widget.dart';
import 'package:hydrobud/widget/ppm_line_chart/ppm_line_chart_widget.dart';
import 'package:hydrobud/widget/water_level_line_chart/water_level_line_chart_widget.dart';
import 'package:hydrobud/widget/water_temp_line_chart/water_temp_line_chart_widget.dart';

import '../../constants/colors.dart';

class QuickAccessWidget extends StatefulWidget {
  const QuickAccessWidget({super.key});

  @override
  State<QuickAccessWidget> createState() => _QuickAccessWidgetState();
}

class _QuickAccessWidgetState extends State<QuickAccessWidget> {
  bool isLoaded = false; // get the value once database is loaded
  String graphColor = 'green'; // set to green by default

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border(
                  top: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none,
                  bottom: BorderSide(
                    color: Colors.grey.shade800,
                    width: 7,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      buildResponsiveContainer(
                        borderColor: pHAccentColor,
                        title: 'PH',
                        value: '1.00',
                        onTap: () {
                          print('PH Container tapped!');
                          setState(() {
                            graphColor = 'green';
                            isLoaded = true;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      buildResponsiveContainer(
                        borderColor: ppmAccentColor,
                        title: 'PPM',
                        value: '1.00',
                        onTap: () {
                          print('PPM Container tapped!');
                          setState(() {
                            graphColor = 'yellow';
                            isLoaded = true;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      buildResponsiveContainer(
                        borderColor: Colors.pink,
                        title: 'TEMP',
                        value: '1.00',
                        onTap: () {
                          print('TEMP Container tapped!');
                          setState(() {
                            graphColor = 'pink';
                            isLoaded = true;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      buildResponsiveContainer(
                        borderColor: Colors.blue,
                        title: 'LVL',
                        value: '1.00',
                        onTap: () {
                          print('LVL Container tapped!');
                          setState(() {
                            graphColor = 'blue';
                            isLoaded = true;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isLoaded
                ? _buildLineGraph(graphColor: graphColor)
                // Loading Indicator for database should be shown only when database is not loaded, not first initialized.
                : const LoadingIndicatorWidget(
                    label: '<Database not Loaded>',
                  )
          ],
        ),
      ),
    );
  }
}

Widget _buildQuickAccessGraph(
    {Color? borderColor, String? title, String? value}) {
  borderColor ??= Colors.white;
  title ??= 'N/A';
  value ??= 'N/A';

  return Stack(
    children: [
      Container(
        width: 63,
        height: 63,
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 4)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.grey.shade100),
              ),
              Text(
                value,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.grey.shade100),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildResponsiveContainer({
  Color? borderColor,
  String? title,
  String? value,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: _buildQuickAccessGraph(
        borderColor: borderColor, title: title, value: value),
  );
}

Widget _buildLineGraph({required String graphColor}) {
  if (graphColor == 'green') {
    return const PhLineChart();
  } else if (graphColor == 'yellow') {
    return const PpmLineChart();
  } else if (graphColor == 'pink') {
    return const WaterTempLineChart();
  } else if (graphColor == 'blue') {
    return const WaterLevelLineChart();
  }

  // This is placeholder, PhLineChart should be shown immediately without selecting containers.
  return const LoadingIndicatorWidget(
    label: '<No chart selected>',
  );
}
