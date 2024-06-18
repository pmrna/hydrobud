import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

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
          color: color ?? WidgetPallete.greenAccent4, // background color
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: borderColor,
            width: 3.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(1, 3),
            )
          ],
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
