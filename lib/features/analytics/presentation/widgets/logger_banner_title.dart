import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class LoggerBannerTitle extends StatelessWidget {
  final int id;
  final String cropName;
  const LoggerBannerTitle({
    super.key,
    required this.id,
    required this.cropName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 346,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
                'lib/core/assets/images/hydroponics_harvest_bg.jpg'),
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
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
        child: Center(
          child: Text(
            'Harvest #$id -\n$cropName',
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
