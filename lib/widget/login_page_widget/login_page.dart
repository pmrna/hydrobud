import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hydrobud/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

final databaseService = DatabaseService(Supabase.instance.client);
final client = databaseService.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signInGoogle() async {
    const webClientId =
        '404254733330-pcnmc9ude3bfsuisr7kd9tq1ao3aodvc.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> _signInFacebook() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await client.auth.signInAnonymously();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check your email for a login link!')),
        );
        _emailController.clear();
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signInAnonymously() async {
    await client.auth.signInAnonymously();
  }

  @override
  // This always listens to the auth state, for when there are auth changes it
  // automatically redirects user to the home page.
  void initState() {
    super.initState();

    _authStateSubscription = client.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
          const SizedBox(height: 28),
          const Text(
            'Hydrobud',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 44),
          const Text(
            'Sign in',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 44),
          FilledButton.icon(
            onPressed: () async {
              _signInGoogle();
            },
            icon: Image.asset('assets/google.png'),
            label: Text(_isLoading ? 'Loading' : 'Continue using Google'),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: _isLoading ? null : null,
            icon: Image.asset('assets/facebook.png'),
            label: Text(_isLoading ? 'Loading' : 'Continue using Facebook'),
          ),
        ],
      ),
    );
  }
}
