import 'package:flutter/material.dart';
import 'package:hydrobud/features/irrigation/domain/entities/irrigation_preset.dart';

class IrrigationPresetsPage extends StatelessWidget {
  final IrrigationPreset preset;

  const IrrigationPresetsPage({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(preset.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(preset.description),
      ),
    );
  }
}
