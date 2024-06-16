import 'package:flutter/material.dart';
import '../widgets/irrigation_card.dart';
import 'package:hydrobud/features/irrigation/presentation/pages/lettuce_preset_page.dart';
import 'package:hydrobud/features/irrigation/presentation/pages/bellpepper_presets_page.dart';
import 'package:hydrobud/features/irrigation/presentation/pages/eegplant_presets_page.dart';
import 'package:hydrobud/features/irrigation/data/repositories/irrigation_repository.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';

class IrrigationPage extends StatelessWidget {
  final IrrigationRepository repository = IrrigationRepository();
  final VoidCallback onFabPressed;

  IrrigationPage({super.key, required this.onFabPressed});

  void navigateToPresetPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LettucePresetsPage(onFabPressed: onFabPressed)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const BellpepperPresetsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EggplantPresetsPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final presets = repository.getPresets();
    final images = [
      'lib/core/assets/images/lettuce_bg.jpg',
      'lib/core/assets/images/bill_pipper.jpg',
      'lib/core/assets/images/talong.jpg',
    ];

    final colors = [
      const Color(0xffA0BC36),
      const Color(0xff9D302D),
      const Color(0xff451D28),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const HeaderText(text: 'Irrigation'),
              const SizedBox(height: 30),
              const Text(
                'Choose your plant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: presets.length,
                itemBuilder: (context, index) {
                  final preset = presets[index];
                  final imagePath = images[index % images.length];
                  return IrrigationCard(
                    borderColor: colors[index % colors.length],
                    title: preset.title,
                    description: preset.description,
                    imagePath: imagePath,
                    onTap: () => navigateToPresetPage(context, index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
