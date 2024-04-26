import 'package:flutter/material.dart';

import 'main_canvas.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainCanvas(),
    );
  }
}
