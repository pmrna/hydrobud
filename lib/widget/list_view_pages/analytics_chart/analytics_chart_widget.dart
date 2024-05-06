import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Tuple<X, Y, Z> {
  final X item1;
  final Y item2;
  final Z item3;
  Tuple(this.item1, this.item2, this.item3);
}

class AnalyticsPageChart extends StatelessWidget {
  const AnalyticsPageChart({Key? key});

  @override
  Widget build(BuildContext context) {
    // Define your data points here
    List<List<Tuple<double, double, double>>> dataPoints = [
      [
        Tuple(0, 12, 20),
        Tuple(0, 0, 3),
        Tuple(0, 5, 20),
      ],
      [
        Tuple(0, 13, 20),
        Tuple(0, 0, 3),
        Tuple(0, 6, 20),
      ],
      [
        Tuple(0, 15, 20),
        Tuple(0, 0, 3),
        Tuple(0, 12, 20),
      ],
      [
        Tuple(0, 15, 20),
        Tuple(0, 0, 3),
        Tuple(0, 12, 20),
      ],
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: BarChart(
            BarChartData(
              barGroups: List.generate(dataPoints.length, (index) {
                return BarChartGroupData(
                  x: index + 1,
                  barRods: List.generate(dataPoints[index].length, (i) {
                    var tuple = dataPoints[index][i];
                    return BarChartRodData(
                      fromY: tuple.item1,
                      toY: tuple.item2,
                      width: tuple.item3,
                      color: Colors.greenAccent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    );
                  }),
                );
              }),
              gridData: const FlGridData(
                show: true,
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                border: const Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                ),
              ),
              groupsSpace: 10,
            ),
          ),
        ),
      ),
    );
  }
}
