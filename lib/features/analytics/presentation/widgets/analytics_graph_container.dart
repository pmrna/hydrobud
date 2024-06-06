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
    print(response);

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
        scalingFactor = 0.2;
        break;
      default:
        scalingFactor = 20.0;
    }

    setState(() {
      this.data = phValues;
      isLoading = false;
    });
  }

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
              vertical: 10.0,
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
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 207,
            color: Colors.white,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 5, 25),
                    child: CustomPaint(
                      painter: BarChartPainter(
                          data: data, scalingFactor: scalingFactor),
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
                  text: 'PPM',
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
          )
        ],
      ),
    );
  }
}

// TODO: SEPERATE BUILDER FOR EACH PARAMS

class BarChartPainter extends CustomPainter {
  final List<double> data;
  final double scalingFactor;

  BarChartPainter({required this.data, required this.scalingFactor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPallete.foregroundColor
      ..style = PaintingStyle.fill;

    const barWidth = 17.0;
    final spaceBetweenBars = (size.width - (12 * barWidth)) / 15;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    // Draw the bars
    for (int i = 0; i < data.length; i++) {
      final barHeight = data[i] * scalingFactor; // Scaling factor for height
      final x = i * (barWidth + spaceBetweenBars);
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
        style: textStyle,
      );

      textPainter.text = bottomTextSpan;
      textPainter.layout();
      final bottomX = x + barWidth / 2 - textPainter.width / 2;
      final bottomY = size.height + 4;

      textPainter.paint(canvas, Offset(bottomX, bottomY));
    }

    // Draw the left titles (Y-axis labels)
    const yAxisLabels = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0];

    for (int i = 0; i < yAxisLabels.length; i++) {
      final yAxisLabel = yAxisLabels[i];
      final yAxisTextSpan = TextSpan(
        text: yAxisLabel.toString(),
        style: textStyle,
      );

      textPainter.text = yAxisTextSpan;
      textPainter.layout();
      const yAxisX = -30;
      final yAxisY = size.height - (yAxisLabel * 20) - textPainter.height / 2;

      textPainter.paint(canvas, Offset(yAxisX.toDouble(), yAxisY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
