import 'package:flutter/material.dart';
import 'package:hydrobud/widget/login_page_widget/login_page.dart';

class LoginCanvas extends StatelessWidget {
  const LoginCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPage(),
    );
  }
}
