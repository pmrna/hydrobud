import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class AuthRichText extends StatelessWidget {
  final String mainText;
  final String clickableText;
  final Widget targetPage;
  const AuthRichText(
      {super.key,
      required this.mainText,
      required this.clickableText,
      required this.targetPage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: mainText,
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: clickableText,
              style: const TextStyle(color: AppPallete.textColorGreen),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => targetPage));
                },
            ),
          ],
        ),
      ),
    );
  }
}
