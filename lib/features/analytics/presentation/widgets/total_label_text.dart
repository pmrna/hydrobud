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
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppPallete.textColorBlack,
      ),
    );
  }
}
