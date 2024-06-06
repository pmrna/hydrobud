import "package:flutter/material.dart";
import 'package:hydrobud/core/theme/pallete.dart';

class BellpepperPresetsPage extends StatelessWidget {
  const BellpepperPresetsPage({super.key});

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
        title: const Text('Preset Page 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.green,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Input 1',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    color: Colors.yellow,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Input 2',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.purple,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Input 3',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Input 4',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
