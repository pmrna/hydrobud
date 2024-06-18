import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/maintain/presentation/pages/maintain_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProcessingIrrigationPage extends StatefulWidget {
  const ProcessingIrrigationPage({super.key});

  @override
  _ProcessingIrrigationPageState createState() =>
      _ProcessingIrrigationPageState();
}

class _ProcessingIrrigationPageState extends State<ProcessingIrrigationPage> {
  int _currentStage = 0;
  double _progress = 0.0;
  bool _isFabDisabled = false;

  final List<String> _messages = [
    'Preparing system',
    'Dosing nutrient solution A & B',
    'Calibrating pH & EC value',
    'Distributing nutrient solution to farm'
  ];

  final List<String> _instructionMessages = [
    '''Make sure that the solution and ph containers are full...\nCheck if the pump is on and connected...\nCheck if connections are complete and not loose...\nMake sure to power up the system...''',
    '''Make sure that pumps are on and connected...\nCheck if you can hear the pumps churning...\nCheck the tubes if there are solutions being added...''',
    '''Double check the values of pH and EC...\nIf in doubt use a water quality measuring pen...\nUse a water quality measuring pen for measuring pH and EC manually...''',
    '''Make sure that the pump is on and connected...\nConfirm proper flow rate and distribution...\nMonitor for any leaks or blockages in pipes and tubes...'''
  ];

  Future<void> _nextStage() async {
    if (_currentStage < _messages.length &&
        _currentStage < _instructionMessages.length) {
      if (mounted) {
        setState(() {
          _isFabDisabled = true;
          _currentStage++;
          _progress += 1 / _messages.length;
        });
      }

      // Use Future.delayed to await the delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _isFabDisabled = false;
        });
      }

      if (_currentStage == _messages.length) {
        final supabase = Supabase.instance.client;

        try {
          await supabase.from('irrigation_presets').update(
              {'transplant_date': DateTime.timestamp().toString()}).eq('id', 1);

          if (mounted) {
            _setIsOngoing();

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MaintainPage(onFabPressed: () {})),
            );
          }
        } catch (error) {
          debugPrint('Error updating transplant_date: $error');
        }
      }
    }
  }

  Future<void> _setIsOngoing() async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('irrigation_presets')
        .update({'is_ongoing': true}).eq('id', 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppPallete.textColorBlack,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const HeaderText(text: 'Lettuce'),
          const SizedBox(height: 30),
          const Text(
            'Processing',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: AppPallete.textColorBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            '......',
            style: TextStyle(
              color: AppPallete.foregroundColor,
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            _currentStage < _instructionMessages.length
                ? _instructionMessages[_currentStage]
                : '',
            style: const TextStyle(
              color: AppPallete.textColorBlack3,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Image(
            image: AssetImage(
                'lib/core/assets/images/processing_hydroponics_bg.png'),
            fit: BoxFit.contain,
          ),
          const Text(
            'Your progress',
            style: TextStyle(
              color: AppPallete.textColorBlack3,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${(_progress * 100).toInt()}% to complete',
            style: const TextStyle(
              fontSize: 24,
              color: AppPallete.textColorGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentStage < _messages.length
                      ? _messages[_currentStage]
                      : '',
                  style: const TextStyle(
                    color: AppPallete.textColorBlack3,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 1),
                const Icon(Icons.access_time_sharp),
                const SizedBox(width: 5),
                const Text(
                  '~10 mins',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppPallete.textColorBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _progress,
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: AppPallete.foregroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 120,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isFabDisabled ? null : _nextStage,
        backgroundColor: _isFabDisabled
            ? AppPallete.textColorGray
            : AppPallete.foregroundColor,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
