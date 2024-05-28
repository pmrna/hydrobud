import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrobud/core/common/widgets/loader.dart';
import 'package:hydrobud/core/utils/show_snackbar.dart';
import 'package:hydrobud/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hydrobud/features/auth/presentation/pages/sign_in_page.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_button.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_field.dart';
import 'package:hydrobud/features/auth/presentation/widgets/auth_rich_text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Form(
              key: formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
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
                    'Sign up',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  AuthField(
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 40),
                  AuthButton(
                    text: 'Sign up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                        print('Clicked!');
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  const AuthRichText(
                    mainText: 'Already have an account? ',
                    clickableText: 'Sign in here',
                    targetPage: SignInPage(),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
