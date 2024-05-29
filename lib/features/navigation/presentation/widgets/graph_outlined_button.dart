import 'package:flutter/material.dart';

class GraphOutlinedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color borderColor;
  final Color? color;
  const GraphOutlinedButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.borderColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: InkSplash.splashFactory,
      child: Container(
        width: 56,
        height: 30,
        decoration: BoxDecoration(
          color: color ?? Colors.transparent, // background color
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
