import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class AuthIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onPressed;
  const AuthIconButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppPallete.textColorWhite,
      ),
      label: Text(
        label,
        style: const TextStyle(color: AppPallete.textColorWhite),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(327, 40),
        backgroundColor: WidgetPallete.greenAccent2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
