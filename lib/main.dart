import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrobud/pages/home/views/home_canvas.dart';
import 'package:hydrobud/widget/account_page_widget/account_page_widget.dart';
import 'package:hydrobud/widget/login_page_widget/login_page.dart';
import 'package:hydrobud/widget/splash_screen_widget/splash_screen_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'lib/.env');
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
      storageOptions: const StorageClientOptions(
        retryAttempts: 10,
      ));

  runApp(const MyApp());
}

class DatabaseService {
  final SupabaseClient client;

  DatabaseService(this.client);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // print('pixelRatio: $pixelRatio'); // 3.5

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hydrobud",
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
