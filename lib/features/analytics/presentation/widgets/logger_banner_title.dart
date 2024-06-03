import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class BannerTitle extends StatelessWidget {
  const BannerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 346,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/lettuce-banner.jpg'),
            fit: BoxFit.fitWidth,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: WidgetPallete.greenAccent3, width: 5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: const Center(
          child: Text(
            'Harvest #1 -\nLettuce',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
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
