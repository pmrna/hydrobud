import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrobud/core/common/widgets/loader.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/graph/domain/entities/chart.dart';
import 'package:hydrobud/features/graph/presentation/bloc/chart_data_bloc.dart';
import 'package:hydrobud/features/navigation/presentation/pages/history_page.dart';

class SingleBarChartWidget extends StatefulWidget {
  const SingleBarChartWidget({super.key});

  @override
  State<SingleBarChartWidget> createState() => _SingleBarChartWidgetState();
}

class _SingleBarChartWidgetState extends State<SingleBarChartWidget> {
  final Map<String, String> labelMapping = {
    'ph_sensor': 'PH',
    'TDS_sensor': 'PPM',
    'Water_temp_sensor': 'TEMP (°C)',
    'Water_level_sensor': 'LEVEL (cm)',
  };

  // order of labels
  final List<String> labelOrder = ['PH', 'PPM', 'TEMP (°C)', 'LEVEL (cm)'];

  // scaling of bar
  final Map<String, double> scalingFactors = {
    'PH': 40.0,
    'PPM': 40.0,
    'TEMP (°C)': 10.0,
    'LEVEL (cm)': 1.0,
  };

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    context.read<ChartDataBloc>().add(FetchChartDataEvent());
  }

  final _stream = supabase.from('sensors').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Chart> charts =
              snapshot.data!.map((maps) => Chart.fromMap(maps)).toList();
          return _buildChart(charts);
        }
        return const Loader();
      },
    );
  }

  Widget _buildChart(List<Chart> data) {
    // sorts labels by comparing raw data to labelOrder to proper order based on labelOrder
    data.sort((a, b) {
      final labelA = labelMapping[a.label.trim()] ?? a.label.trim();
      final labelB = labelMapping[b.label.trim()] ?? b.label.trim();
      return labelOrder.indexOf(labelA).compareTo(labelOrder.indexOf(labelB));
    });

    return ListView(
      children: data.map((chart) => _buildBar(chart)).toList(),
    );
  }

  Widget _buildBar(Chart chart) {
    final staticLabel = labelMapping[chart.label.trim()] ?? chart.label.trim();
    final scalingFactor = scalingFactors[staticLabel] ?? 1.0;
    final barWidth = chart.value * scalingFactor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                staticLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              Text(
                chart.value.toString().trim(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 15.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.grey.shade600),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: ColoredBox(
                  color: Colors.grey.shade600,
                ),
              ),
              Container(
                height: 15.0,
                width: barWidth, // Adjust the multiplier to scale the bar width
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: WidgetPallete.greenAccent),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: const ColoredBox(
                  color: WidgetPallete.greenAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noChartData() {
    return const Center(
      child: Text('No chart data available'),
    );
  }
}
