import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class TotalLabelText extends StatelessWidget {
  final String text;
  const TotalLabelText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppPallete.textColorBlack,
        letterSpacing: -1,
      ),
      textAlign: TextAlign.center,
    );
  }
}
