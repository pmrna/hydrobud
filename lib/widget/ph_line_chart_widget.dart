import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';

class pHLineChart extends StatefulWidget {
  const pHLineChart({super.key});

  @override
  State<pHLineChart> createState() => _pHLineChartState();
}

class _pHLineChartState extends State<pHLineChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 10,
            left: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: graphBackgroundColor,
                border: Border.all(
                  color: graphLineColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                    left: 25,
                    top: 5,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'pH Level',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '1.00',
                              style: TextStyle(
                                color: primaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Today, 11:59 AM',
                              style: TextStyle(
                                color: primaryTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1.5,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  color: dividerColor,
                ),
                AspectRatio(
                  aspectRatio: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                    ),
                    child: LineChart(
                      LineChartData(
                        lineTouchData: const LineTouchData(enabled: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: false,
                            isStepLineChart: true,
                            barWidth: 4,
                            color: pHBarLineColor,
                            shadow: Shadow(
                                color: pHBarLineShadowColor,
                                offset: Offset(2, 2),
                                blurRadius: 10.0),
                            spots: const [
                              FlSpot(0, 0),
                              FlSpot(1, 1.2),
                              FlSpot(2, 4.5),
                              FlSpot(3, 6.0),
                              FlSpot(4, 5.5),
                              FlSpot(5, 1.0),
                              FlSpot(6, 0),
                            ],
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  pHTertiaryGradientColor,
                                  pHSecondaryGradientColor,
                                  pHPrimaryGradientColor,
                                ],
                                transform: GradientRotation(60.0),
                                stops: [
                                  0.3,
                                  0.6,
                                  0.9,
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                            ),
                            dotData: FlDotData(
                              show: true,
                            ),
                          ),
                        ],
                        minY: 0,
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide(
                              color: graphBorderLineColor,
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: graphBorderLineColor,
                              width: 2,
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              reservedSize: 15,
                              showTitles: true,
                              getTitlesWidget: getHackTitles,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text(
                              'Time',
                              style: TextStyle(
                                color: primaryTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              ),
                            ),
                            sideTitles: SideTitles(
                                reservedSize: 30,
                                showTitles: true,
                                getTitlesWidget: getBottomTitles),
                          ),
                          leftTitles: AxisTitles(
                            axisNameWidget: Text(
                              'Value',
                              style: TextStyle(
                                color: primaryTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              ),
                            ),
                            sideTitles: SideTitles(
                                reservedSize: 25,
                                showTitles: true,
                                getTitlesWidget: getLeftTitles,
                                interval: 1),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                                reservedSize: 20,
                                showTitles: true,
                                getTitlesWidget: getHackTitles),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  child: Center(
                    child: Text(
                      '1H',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide.none,
                      right: BorderSide(
                        width: 2,
                        color: borderColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text(
                      '4H',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide.none,
                      right: BorderSide(
                        width: 2,
                        color: borderColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text(
                      '6H',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide.none,
                      right: BorderSide(
                        width: 2,
                        color: borderColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text(
                      '12H',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide.none,
                      right: BorderSide(
                        width: 2,
                        color: borderColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text(
                      '24H',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide.none,
                        left: BorderSide.none,
                        bottom: BorderSide.none,
                        right: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: textGraphColor,
      fontWeight: FontWeight.w900,
      fontSize: 13,
    );
    String bottomText;
    switch (value.toInt()) {
      case 0:
        bottomText = '00:00';
        break;
      case 1:
        bottomText = '04:00';
        break;
      case 2:
        bottomText = '08:00';
        break;
      case 3:
        bottomText = '12:00';
        break;
      case 4:
        bottomText = '16:00';
        break;
      case 5:
        bottomText = '20:00';
        break;
      case 6:
        bottomText = '23:59';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      fitInside: SideTitleFitInsideData.fromTitleMeta(
        meta,
        enabled: true,
        distanceFromEdge: -16,
      ),
      child: Text(
        bottomText,
        style: style,
      ),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: textGraphColor,
      fontWeight: FontWeight.w900,
      fontSize: 13,
    );
    String leftText;
    if (value == 0) {
      leftText = '0';
    } else if (value == 1) {
      leftText = '1';
    } else if (value == 2) {
      leftText = '2';
    } else if (value == 3) {
      leftText = '3';
    } else if (value == 4) {
      leftText = '4';
    } else if (value == 5) {
      leftText = '5';
    } else if (value == 6) {
      leftText = '6';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(leftText, style: style),
    );
  }

  Widget getHackTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.transparent,
    );
    return Text('hack', style: style);
  } // a hack for titles: fixed stupid text clipping when not showing a title side.
}
