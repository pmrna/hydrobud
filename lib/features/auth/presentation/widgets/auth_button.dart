import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(327, 40),
          backgroundColor: WidgetPallete.greenAccent2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppPallete.textColorWhite,
        ),
      ),
    );
  }
}
