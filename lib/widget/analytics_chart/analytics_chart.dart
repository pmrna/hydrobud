import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Tuple<X, Y, Z> {
  final X item1;
  final Y item2;
  final Z item3;
  Tuple(this.item1, this.item2, this.item3);
}

class AnalyticsPageChart extends StatefulWidget {
  const AnalyticsPageChart({Key? key}) : super(key: key);

  @override
  _AnalyticsPageChartState createState() => _AnalyticsPageChartState();
}

final supabase = Supabase.instance.client;

class _AnalyticsPageChartState extends State<AnalyticsPageChart> {
  String selectedParam = 'PH';
  var phValue;

  List<List<Tuple<double, double, double>>> pHData = [];

  List<List<Tuple<double, double, double>>> ppmData = [
    [Tuple(0, 13, 20)],
  ];

  List<List<Tuple<double, double, double>>> tempData = [
    [Tuple(0, 15, 20)],
  ];

  List<List<Tuple<double, double, double>>> levelData = [
    [Tuple(0, 15, 20)],
  ];

  List<List<Tuple<double, double, double>>> dataPoints = [];

  @override
  void initState() {
    super.initState();
    dataPoints = pHData;
    receiveData();
  }

  Future<void> receiveData() async {
    supabase
        .channel('public:sensors:value')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'sensors',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: 1,
          ),
          callback: (payload) {
            debugPrint('Change received: ${payload.toString()}');
            setState(() {
              phValue = payload.newRecord['value'].toDouble();
              if (pHData.isNotEmpty) {
                pHData[0][0] = Tuple(0, phValue, 20);
              } else {
                pHData.add([Tuple(0, phValue, 20)]);
              }
            });
          },
        )
        .subscribe();
  }

  void updateParam(String param) {
    setState(() {
      selectedParam = param;
      if (param == 'PH') {
        dataPoints = pHData;
      } else if (param == 'PPM') {
        dataPoints = ppmData;
      } else if (param == 'TEMP') {
        dataPoints = tempData;
      } else if (param == 'LEVEL') {
        dataPoints = levelData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.only(bottom: 10, top: 5, left: 5, right: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: BarChart(
                      BarChartData(
                        barGroups: List.generate(dataPoints.length, (index) {
                          return BarChartGroupData(
                            x: index + 1,
                            barRods:
                                List.generate(dataPoints[index].length, (i) {
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => updateParam('PH'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedParam == 'PH' ? Colors.green : Colors.grey,
                          ),
                        ),
                        child: const Text('PH'),
                      ),
                      ElevatedButton(
                        onPressed: () => updateParam('PPM'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedParam == 'PPM'
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                        child: const Text('PPM'),
                      ),
                      ElevatedButton(
                        onPressed: () => updateParam('TEMP'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedParam == 'TEMP'
                                ? Colors.pink[700]
                                : Colors.grey,
                          ),
                        ),
                        child: const Text('TEMP'),
                      ),
                      ElevatedButton(
                        onPressed: () => updateParam('LEVEL'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedParam == 'LEVEL'
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        child: const Text('LEVEL'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
