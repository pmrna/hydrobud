import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: 21,
        width: 120,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            splashFactory: InkSplash.splashFactory,
            foregroundColor: AppPallete.textColorBlack,
            padding: const EdgeInsets.all(0),
          ),
          child: const Text('Forgot Password?'),
        ),
      ),
    );
  }
}
