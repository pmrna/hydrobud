import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/navigation/presentation/pages/history_logger_page.dart';

class HistoryBannerButton extends StatelessWidget {
  final String harvestDate;
  final int id;
  final String cropName;
  const HistoryBannerButton({
    super.key,
    required this.harvestDate,
    required this.id,
    required this.cropName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HistoryLoggerPage(id: id),
          ),
        );
      },
      splashFactory: InkSplash.splashFactory,
      child: Container(
        width: MediaQuery.of(context).size.width,
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
              harvestDate,
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
            Center(
              child: Text(
                'Harvest #$id\n$cropName',
                style: const TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }
}
