import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/maintain/presentation/pages/maintain_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/wrapper.dart';

class BannerButton extends StatelessWidget {
  final String cropName;
  const BannerButton({super.key, required this.cropName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaintainPage(onFabPressed: () {}),
          ),
        );
      },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              cropName,
              style: const TextStyle(
                color: AppPallete.textColorWhite,
                fontWeight: FontWeight.w800,
                fontSize: 26,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(1, 3),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Check on your ${cropName.toLowerCase()} crop',
              style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
