import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/analytics/presentation/widgets/graph_outlined_button.dart';

class AnalyticsGraphContainer extends StatefulWidget {
  const AnalyticsGraphContainer({super.key});

  @override
  State<AnalyticsGraphContainer> createState() =>
      _AnalyticsGraphContainerState();
}

class _AnalyticsGraphContainerState extends State<AnalyticsGraphContainer> {
  bool isLoading = true;
  List<double> data = [];
  double scalingFactor = 1.0; // Default scaling factor
  Offset? tapPosition; // Store tap position of the tapped bar
  int? tappedIndex; // Store the index of the tapped bar

  @override
  void initState() {
    fetchData('ph');
    super.initState();
  }

  Future<void> fetchData(String sensorType) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('${sensorType}_data')
        .select('value')
        .order('created_at', ascending: false)
        .limit(12);
    debugPrint(response.toString());

    final data = response;

    final phValues = data
        .map((e) => e['value'] as num?)
        .where((value) => value != null)
        .map((value) => value!.toDouble())
        .toList();

    switch (sensorType) {
      case 'water_temp':
        scalingFactor = 1.0;
        break;
      case 'water_level':
        scalingFactor = 1;
        break;
      case 'ec':
        scalingFactor = 100.0;
        break;
      default:
        scalingFactor = 20.0;
    }

    if (mounted) {
      setState(() {
        this.data =
            phValues.reversed.toList(); // Reverse the order of the values
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 346,
      height: 335,
      decoration: BoxDecoration(
        color: WidgetPallete.greenAccent4,
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
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
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 207,
                color: AppPallete.whiteColor,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 5, 25),
                        child: CustomPaint(
                          painter: _BarChartPainter(
                            data: data,
                            scalingFactor: scalingFactor,
                          ),
                        ),
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
                      onTap: () {
                        fetchData('ph');
                      },
                      text: 'PH',
                      borderColor: WidgetPallete.greenStroke,
                    ),
                    GraphOutlinedButton(
                      onTap: () {
                        fetchData('ec');
                      },
                      text: 'EC',
                      borderColor: WidgetPallete.yellowstroke,
                    ),
                    GraphOutlinedButton(
                      onTap: () {
                        fetchData('water_temp');
                      },
                      text: 'TEMP',
                      borderColor: WidgetPallete.pinkStroke,
                    ),
                    GraphOutlinedButton(
                      onTap: () {
                        fetchData('water_level');
                      },
                      text: 'LEVEL',
                      borderColor: WidgetPallete.blueStroke,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<double> data;
  final double scalingFactor;

  _BarChartPainter({
    required this.data,
    required this.scalingFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = WidgetPallete.greenAccent1
      ..style = PaintingStyle.fill;

    final totalBars = data.length;
    final availableWidth = size.width;
    final totalSpacing = availableWidth / 5;
    final barWidth = (availableWidth - totalSpacing) / totalBars;
    final spaceBetweenBars =
        (availableWidth - (totalBars * barWidth)) / (totalBars + 1);

    final textPainter = TextPainter(
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );

    const bottomTextStyle = TextStyle(
      color: AppPallete.textColorBlack,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    const leftTextStyle = TextStyle(
      color: AppPallete.textColorBlack2,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    final maxBarHeight = size.height - 20;

    final maxValue = data.reduce((a, b) => a > b ? a : b);

    // Draw the bars
    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / maxValue) * maxBarHeight;
      final x = (i + 1) * spaceBetweenBars + i * barWidth;
      final y = size.height - barHeight;

      final roundedRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(5),
      );

      canvas.drawRRect(
        roundedRect,
        paint,
      );

      // Draw the bottom labels (X-axis)
      final bottomTextSpan = TextSpan(
        text: '${i + 1}h',
        style: bottomTextStyle,
      );

      textPainter.text = bottomTextSpan;
      textPainter.layout();
      final bottomX = x + barWidth / 2 - textPainter.width / 2;
      final bottomY = size.height + 4;

      textPainter.paint(canvas, Offset(bottomX, bottomY));
    }

    const numYLabels = 5; // Number of Y-axis labels
    final interval = maxValue / numYLabels;

    for (int i = 0; i <= numYLabels; i++) {
      final yAxisLabel = (i * interval).toStringAsFixed(1);
      final yAxisTextSpan = TextSpan(
        text: yAxisLabel,
        style: leftTextStyle,
      );

      textPainter.text = yAxisTextSpan;
      textPainter.layout();
      const yAxisX = -40;
      final yAxisY = size.height -
          (i * (interval / maxValue) * maxBarHeight) -
          textPainter.height / 2;

      textPainter.paint(canvas, Offset(yAxisX.toDouble(), yAxisY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
