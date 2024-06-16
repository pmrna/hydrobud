import 'package:flutter/material.dart';

class TotalValueText extends StatelessWidget {
  final String text;
  const TotalValueText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
