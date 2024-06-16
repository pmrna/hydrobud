import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class BannerButton extends StatelessWidget {
  const BannerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashFactory: InkSplash.splashFactory,
      child: Container(
        width: 346,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('lib/core/assets/images/lettuce_bg.jpg'),
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: WidgetPallete.bannerBorderColor, width: 5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(1, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Text(
              '10 \nDays',
              style: TextStyle(
                color: AppPallete.textColorWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 4,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              color: Colors.white,
              thickness: 2,
              width: 40,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Harvest #1 - Lettuce',
                  style: TextStyle(
                    color: AppPallete.textColorWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(1, 3),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Check on your lettuce crop',
                  style: TextStyle(
                    color: AppPallete.textColorWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(1, 2),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Maintaining nutrient concentration...',
                  style: TextStyle(
                    color: AppPallete.textColorWhite,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(1, 2),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
