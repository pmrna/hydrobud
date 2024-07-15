import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/loader.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsCapacityGraph extends StatefulWidget {
  const AnalyticsCapacityGraph({super.key});

  @override
  State<AnalyticsCapacityGraph> createState() => _AnalyticsCapacityGraphState();
}

class _AnalyticsCapacityGraphState extends State<AnalyticsCapacityGraph> {
  static const double totalCapacity = 500; // setter for total capacity

  final _stream = Supabase.instance.client
      .from('container_capacity')
      .stream(primaryKey: ['id']);

  final Map<String, String> labelMapping = {
    'nutrient_a': 'Solution A',
    'nutrient_b': 'Solution B',
    'pH_up': 'PH Up',
    'pH_down': 'PH Down',
  };

  @override
  void initState() {
    super.initState();
  }

  void _showRefillDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nutrientAController = TextEditingController();
    final TextEditingController nutrientBController = TextEditingController();
    final TextEditingController phUpController = TextEditingController();
    final TextEditingController phDownController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Refill Containers'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextFormField(
                    controller: nutrientAController,
                    decoration: const InputDecoration(
                      labelText: 'Solution A',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: nutrientBController,
                    decoration: const InputDecoration(
                      labelText: 'Solution B',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: phUpController,
                    decoration: const InputDecoration(
                      labelText: 'PH Up',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: phDownController,
                    decoration: const InputDecoration(
                      labelText: 'PH Down',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final supabase = Supabase.instance.client;

                  final updates = [
                    {'controller': nutrientAController, 'name': 'nutrient_a'},
                    {'controller': nutrientBController, 'name': 'nutrient_b'},
                    {'controller': phUpController, 'name': 'pH_up'},
                    {'controller': phDownController, 'name': 'pH_down'},
                  ];

                  for (var update in updates) {
                    final controller =
                        update['controller'] as TextEditingController;
                    final name = update['name'] as String;
                    if (controller.text.isNotEmpty) {
                      final value = int.tryParse(controller.text);
                      if (value != null) {
                        await supabase.from('container_capacity').update(
                            {'capacity': value}).eq('container_name', name);
                      }
                    }
                  }
                  if (mounted) {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> capacityData = snapshot.data!;
          return _buildChart(capacityData);
        }
        return const Loader();
      },
    );
  }

  Widget _buildChart(List<Map<String, dynamic>> data) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppPallete.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          color: WidgetPallete.greenStroke,
          width: 5.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Container Capacity',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                const Spacer(flex: 1),
                TextButton(
                  onPressed: () => _showRefillDialog(context),
                  child: const Text(
                    'Refill',
                    style: TextStyle(
                      color: AppPallete.textColorBlack,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.sublist(0, data.length ~/ 2).map((entry) {
                    return _CapacityItem(
                      label: labelMapping[entry['container_name']] as String,
                      value: (entry['capacity'] as num).toInt(),
                      totalCapacity: totalCapacity,
                    );
                  }).toList(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.sublist(data.length ~/ 2).map((entry) {
                    return _CapacityItem(
                      label: labelMapping[entry['container_name']] as String,
                      value: (entry['capacity'] as num).toInt(),
                      totalCapacity: totalCapacity,
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CapacityItem extends StatelessWidget {
  final String label;
  final int value;
  final double totalCapacity;

  const _CapacityItem({
    required this.label,
    required this.value,
    required this.totalCapacity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                height: 16.0,
                width: 130.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              Container(
                height: 16.0,
                width: value / totalCapacity * 130.0,
                decoration: BoxDecoration(
                  color: WidgetPallete.greenAccent1,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '$value mL of $totalCapacity mL',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
