import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';

import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HydroBud",
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          background: Colors.grey.shade900,
          onBackground: Colors.black,
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: tertiaryColor,
          outline: outlineColor,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
