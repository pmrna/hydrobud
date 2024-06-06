// lib/features/irrigation/presentation/pages/lettuce_presets_page.dart
import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/common/widgets/labels_text.dart';
import 'package:hydrobud/features/irrigation/presentation/widgets/irrigation_text_field.dart';
import 'package:hydrobud/features/irrigation/data/repositories/lettuce_preset_repository_impl.dart';
import 'package:hydrobud/features/irrigation/domain/entities/lettuce_preset.dart';

class LettucePresetsPage extends StatefulWidget {
  const LettucePresetsPage({super.key});

  @override
  _LettucePresetsPageState createState() => _LettucePresetsPageState();
}

class _LettucePresetsPageState extends State<LettucePresetsPage> {
  final _formKey = GlobalKey<FormState>();
  final _phLevelController = TextEditingController(text: '6.0');
  final _waterConcentrationController = TextEditingController(text: '1.5');
  final _waterTemperatureController = TextEditingController(text: '24.0');
  final _litersOfWaterController = TextEditingController(text: '70');

  final _repository = IrrigationRepositoryImpl();

  @override
  void dispose() {
    _phLevelController.dispose();
    _waterConcentrationController.dispose();
    _waterTemperatureController.dispose();
    _litersOfWaterController.dispose();
    super.dispose();
  }

  Future<void> _savePreset() async {
    if (_formKey.currentState!.validate()) {
      final preset = IrrigationPreset(
        phLevel: double.parse(_phLevelController.text),
        waterConcentration: double.parse(_waterConcentrationController.text),
        waterTemperature: double.parse(_waterTemperatureController.text),
        litersOfWater: int.parse(_litersOfWaterController.text),
      );

      try {
        await _repository.savePreset(preset);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save preset: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: HeaderText(
                    text: "Lettuce",
                  ),
                ),
                const SizedBox(height: 30),
                const LabelText(text: 'Preset'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'pH Level',
                        backgroundColor: Colors.green.shade50,
                        borderColor: Colors.green,
                        controller: _phLevelController,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Water Concentration',
                        backgroundColor: Colors.yellow.shade50,
                        borderColor: Colors.yellow,
                        controller: _waterConcentrationController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Water Temperature',
                        backgroundColor: Colors.red.shade50,
                        borderColor: Colors.red,
                        controller: _waterTemperatureController,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Liters of Water',
                        backgroundColor: Colors.blue.shade50,
                        borderColor: Colors.blue,
                        controller: _litersOfWaterController,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LabelText(text: 'Recommendation'),
                      const SizedBox(height: 20),
                      Image.asset('lib/core/assets/images/letus-rec.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            _savePreset();
            debugPrint('data uploaded');
            Navigator.of(context).pop();
          },
          label: const Text('Proceed', style: TextStyle(color: Colors.white)),
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: AppPallete.foregroundColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
