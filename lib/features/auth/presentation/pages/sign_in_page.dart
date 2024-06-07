import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrobud/core/common/widgets/loader.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/core/utils/show_snackbar.dart';
import 'package:hydrobud/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hydrobud/features/auth/presentation/pages/sign_up_page.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_button.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_field.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_icon_button.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_rich_text_button.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_text_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackbar(context, 'SignInError: ${state.message}');
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 113, horizontal: 24),
            children: <Widget>[
              Container(
                width: 134,
                height: 134,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.black12,
                      width: 2,
                    ),
                    shape: BoxShape.circle),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hydrobud',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BobbyJones',
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Sign in',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              AuthField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 5),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              const AuthTextButton(),
              AuthButton(
                text: 'Sign in',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                  }
                },
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Continue without signing in',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.textColorBlack,
                ),
              ),
              const SizedBox(height: 15),
              AuthIconButton(
                onPressed: () {},
                label: 'Sign in anonymously',
                icon: Icons.person_rounded,
              ),
              const SizedBox(height: 40),
              const AuthRichText(
                mainText: 'Don\'t have an account? ',
                clickableText: 'Sign up',
                targetPage: SignUpPage(),
              ),
            ],
          ),
        );
      },
    ));
  }
}
