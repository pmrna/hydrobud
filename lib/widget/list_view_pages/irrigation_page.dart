import 'package:flutter/material.dart';

class IrrigationPage extends StatelessWidget {
  const IrrigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Irrigation'),
      ),

      // rest of codes here
    );
  }
}
