import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/common/widgets/labels_text.dart';
import 'package:hydrobud/features/irrigation/presentation/pages/processing_page.dart';
import 'package:hydrobud/features/irrigation/presentation/widgets/irrigation_text_field.dart';
import 'package:hydrobud/features/irrigation/data/repositories/lettuce_preset_repository_impl.dart';
import 'package:hydrobud/features/irrigation/domain/entities/lettuce_preset.dart';

import '../widgets/recommendation_chart.dart';

class BellpepperPresetsPage extends StatefulWidget {
  final VoidCallback onFabPressed;

  const BellpepperPresetsPage({super.key, required this.onFabPressed});

  @override
  _BellpepperPresetsPageState createState() => _BellpepperPresetsPageState();
}

class _BellpepperPresetsPageState extends State<BellpepperPresetsPage> {
  final _formKey = GlobalKey<FormState>();
  final _phLevelController = TextEditingController();
  final _waterConcentrationController = TextEditingController();
  final _waterTemperatureController = TextEditingController();
  final _litersOfWaterController = TextEditingController();

  final _repository = IrrigationRepositoryImpl();

  @override
  void dispose() {
    _phLevelController.dispose();
    _waterConcentrationController.dispose();
    _waterTemperatureController.dispose();
    _litersOfWaterController.dispose();
    super.dispose();
  }

  IrrigationPreset? _createPreset() {
    try {
      return IrrigationPreset(
        phLevel: double.parse(_phLevelController.text),
        waterConcentration: double.parse(_waterConcentrationController.text),
        waterTemperature: double.parse(_waterTemperatureController.text),
        litersOfWater: int.parse(_litersOfWaterController.text),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid input: $e')),
      );
      return null;
    }
  }

  Future<void> _savePreset() async {
    if (_formKey.currentState!.validate()) {
      final preset = _createPreset();
      if (preset == null) return;

      try {
        await _repository.savePreset(preset);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Preset saved successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save preset: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const HeaderText(
              text: "Bell pepper",
            ),
            const SizedBox(height: 30),
            const LabelText(text: 'Preset'),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter PH level',
                    labelText: 'PH level',
                    backgroundColor: WidgetPallete.greenAccent1,
                    borderColor: WidgetPallete.greenAccent2,
                    controller: _phLevelController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter EC value',
                    labelText: 'Water concentration',
                    backgroundColor: WidgetPallete.yellowAccent,
                    borderColor: WidgetPallete.yellowstroke,
                    controller: _waterConcentrationController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter temperature',
                    labelText: 'Water temperature',
                    backgroundColor: WidgetPallete.pinkAccent,
                    borderColor: WidgetPallete.pinkStroke,
                    controller: _waterTemperatureController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter liters of water',
                    labelText: 'Liters of water',
                    backgroundColor: WidgetPallete.blueAccent,
                    borderColor: WidgetPallete.blueStroke,
                    controller: _litersOfWaterController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const LabelText(text: 'Recommendations'),
            const SizedBox(height: 30),
            const RecommendationChart(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _savePreset();
          debugPrint('Lettuce irrigation preset uploaded');
          widget.onFabPressed();
          const ProcessingIrrigationPage();
        },
        backgroundColor: AppPallete.foregroundColor,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
