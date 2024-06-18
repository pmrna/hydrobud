import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class RecommendationChart extends StatelessWidget {
  const RecommendationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('lib/core/assets/icons/rec_ph_icon.png'),
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                'PH',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 1),
              Text(
                '5.5 - 7.0',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Divider(
            color: WidgetPallete.dividerColor,
            thickness: 3,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('lib/core/assets/icons/rec_ec_icon.png'),
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                'CONCENTRATION (EC)',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 1),
              Text(
                '1.6 - 1.9',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Divider(
            color: WidgetPallete.dividerColor,
            thickness: 3,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('lib/core/assets/icons/rec_temp_icon.png'),
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                'TEMPERATURE (°C)',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 1),
              Text(
                '20 - 25',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Divider(
            color: WidgetPallete.dividerColor,
            thickness: 3,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('lib/core/assets/icons/rec_vol_icon.png'),
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                'VOLUME (L)',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 1),
              Text(
                '5L - 15L',
                style: TextStyle(
                  color: AppPallete.textColorBlack3,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Divider(
            color: WidgetPallete.dividerColor,
            thickness: 3,
          ),
        ],
      ),
    );
  }
}
