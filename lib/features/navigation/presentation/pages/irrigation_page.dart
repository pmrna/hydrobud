import 'package:flutter/material.dart';
import '../widgets/irrigation_card.dart';
import 'package:hydrobud/features/irrigation/domain/entities/irrigation_preset.dart';
import 'package:hydrobud/features/irrigation/data/repositories/irrigation_repository.dart';
import 'package:hydrobud/features/irrigation/presentation/pages/irrigation_presets_page.dart';

class IrrigationPage extends StatelessWidget {
  final IrrigationRepository repository = IrrigationRepository();

  IrrigationPage({super.key});

  void navigateToPreset(BuildContext context, IrrigationPreset preset) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IrrigationPresetsPage(preset: preset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final presets = repository.getPresets();
    final images = [
      'lib/core/assets/images/analytics_bg.jpg',
      'lib/core/assets/images/irrigation_bg.jpg',
      'lib/core/assets/images/logger_bg.jpg',
    ];

    final colors = [
      Colors.green,
      Colors.purple,
      Colors.red,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Irrigation')),
      body: ListView.builder(
        itemCount: presets.length,
        itemBuilder: (context, index) {
          final preset = presets[index];
          final imagePath = images[index % images.length];
          return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
            child: IrrigationCard(
              borderColor: colors[index % colors.length],
              title: preset.title,
              description: preset.description,
              imagePath: imagePath,
              onTap: () => navigateToPreset(context, preset),
            ),
          );
        },
      ),
    );
  }
}
