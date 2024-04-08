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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundGraphColor,
          border: Border.all(
            width: 2.5,
            color: borderGraphColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      top: BorderSide.none,
                      left: BorderSide.none,
                      right: BorderSide.none,
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'pH',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            color: outlineColor),
                      ),
                      Column(
                        children: [
                          Text(
                            '1.00',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: outlineColor),
                          ),
                          Text(
                            'Today, 12:00',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: outlineColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  top: 15,
                  bottom: 15,
                  left: 15,
                ),
                child: LineChart(
                  LineChartData(
                    lineTouchData: const LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 0),
                          FlSpot(1, 1.24),
                          FlSpot(2, 4.0),
                          FlSpot(3, 4.5),
                          FlSpot(4, 5.5),
                          FlSpot(5, 6.0),
                          FlSpot(6, 1.0),
                        ],
                        shadow: Shadow(
                          color: Colors.green.shade900,
                          offset: Offset(3, 3),
                        ),
                        isCurved: false,
                        isStepLineChart: true,
                        barWidth: 4,
                        color: Colors.greenAccent.shade700,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.green.shade500,
                        ),
                        dotData: const FlDotData(
                          show: true,
                        ),
                      ),
                    ],
                    minY: 0,
                    minX: 0,
                    //maxY: 10,   //can be used to display mins,hours, etc. : 4h,12h, 24h, etc.
                    //maxX: 10,   //can be used to display mins,hours, etc. : 4h,12h, 24h, etc.
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(
                        sideTitles: const SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 18,
                          getTitlesWidget: getBottomTitles,
                        ),
                        axisNameWidget: Text(
                          'Time',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 20,
                          getTitlesWidget: getLeftTitles,
                        ),
                        axisNameWidget: Text(
                          'Value',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: textLineGraphColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
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
      fitInside: SideTitleFitInsideData.fromTitleMeta(
        meta,
        distanceFromEdge: -10,
      ),
      space: 10,
      child: Text(
        bottomText,
        style: style,
      ),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: textLineGraphColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
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
      fitInside: SideTitleFitInsideData.fromTitleMeta(
        meta,
        distanceFromEdge: -10,
      ),
      space: 10,
      child: Text(leftText, style: style),
    );
  }
}
