import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class TextLabel extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  const TextLabel({
    super.key,
    required this.text,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color ?? AppPallete.textColorBlack,
      ),
    );
  }
}
