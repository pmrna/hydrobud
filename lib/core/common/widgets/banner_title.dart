import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class BannerTitle extends StatelessWidget {
  final String text;
  final String imagePath;
  const BannerTitle({super.key, required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: WidgetPallete.greenAccent3, width: 5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(1, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 4),
                  blurRadius: 10,
                )
              ],
              wordSpacing: -2,
              letterSpacing: -1,
            ),
          ),
        ));
  }
}
