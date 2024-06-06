import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class HeadingsText extends StatelessWidget {
  final String mainText;
  final double? mainSize;
  final double? subSize;
  final String? subText;
  final Color? mainColor;
  final Color? subColor;
  const HeadingsText({
    super.key,
    required this.mainText,
    this.mainSize,
    this.subSize,
    this.subText,
    this.mainColor,
    this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      text: TextSpan(
        text: mainText,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: mainSize ?? 12,
          color: mainColor ?? AppPallete.textColorBlack,
        ),
        children: [
          TextSpan(
            text: subText,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: subSize ?? 12,
              color: subColor ?? AppPallete.textColorBlack,
            ),
          ),
        ],
      ),
    );
  }
}
