import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/banner_title.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/features/irrigation/presentation/widgets/irrigation_text_field.dart';
import 'package:hydrobud/features/maintain/presentation/widgets/progress_timeline.dart';
import 'package:hydrobud/features/maintain/repositories/maintain_preset_repository_impl.dart';
import 'package:hydrobud/features/irrigation/domain/entities/lettuce_preset.dart';
import 'package:hydrobud/features/navigation/presentation/pages/logger_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class MaintainPage extends StatefulWidget {
  final VoidCallback onFabPressed;

  const MaintainPage({super.key, required this.onFabPressed});

  @override
  _MaintainPageState createState() => _MaintainPageState();
}

class _MaintainPageState extends State<MaintainPage> {
  final _formKey = GlobalKey<FormState>();

  final _phLevelController = TextEditingController();
  final _waterConcentrationController = TextEditingController();
  final _waterTemperatureController = TextEditingController();
  final _litersOfWaterController = TextEditingController();

  String _transplantDateDisplay = '';

  final _repository = MaintainRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _setValuesFromDB();
  }

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

  Future<void> _setValuesFromDB() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('irrigation_presets').select(
        'transplant_date, ph_level, water_concentration, water_temperature, liters_of_water');

    final transplantDate = DateTime.parse(response[0]['transplant_date']);

    if (mounted) {
      setState(() {
        _transplantDateDisplay =
            DateFormat.yMMMMd('en_US').format(transplantDate).toString();

        _phLevelController.text = response[0]['ph_level'].toString();
        _waterConcentrationController.text =
            response[0]['water_concentration'].toString();
        _waterTemperatureController.text =
            response[0]['water_temperature'].toString();
        _litersOfWaterController.text =
            response[0]['liters_of_water'].toString();
      });
    }
  }

  Future<void> _proceed() async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.from('irrigation_presets').update(
          {'harvest_date': DateTime.timestamp().toString()}).eq('id', 1);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoggerPage()),
        );
      }
    } catch (error) {
      debugPrint('Error updating transplant_date: $error');
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
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => const Wrapper(),
            ));
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppPallete.textColorBlack,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            const HeaderText(
              text: "Maintaining",
            ),
            const SizedBox(height: 30),
            const BannerTitle(
              text: 'Lettuce',
              imagePath: 'lib/core/assets/images/lettuce_bg.jpg',
            ),
            const SizedBox(height: 25),
            const Text(
              'Transplant Date',
              style: TextStyle(
                color: AppPallete.textColorBlack3,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              _transplantDateDisplay,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                const Text(
                  'Maintainance Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 1),
                TextButton(
                    onPressed: () {
                      _savePreset();
                      debugPrint('data uploaded');
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorBlack,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter pH level',
                    labelText: 'PH Level',
                    backgroundColor: WidgetPallete.greenAccent1,
                    borderColor: WidgetPallete.greenAccent2,
                    controller: _phLevelController,
                  ),
                ),
                const SizedBox(width: 16.0),
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
            const SizedBox(height: 16.0),
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
                const SizedBox(width: 16.0),
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
            const Text(
              'Progress Timeline',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.textColorBlack),
            ),
            const SizedBox(height: 20),
            const ProgressTimeline(),
            const SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _proceed();
        },
        label: const Text('Proceed', style: TextStyle(color: Colors.white)),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundColor: AppPallete.foregroundColor,
      ),
    );
  }
}
