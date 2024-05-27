import 'package:flutter/material.dart';
import 'package:hydrobud/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../widget/home_screen_widget/home_screen_widget.dart';

final databaseService = DatabaseService(Supabase.instance.client);
final client = databaseService.client;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    try {
      await client.auth.signOut();
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
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: 315,
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.lightGreenAccent,
                ),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  bottom: 20,
                ),
                child: ListView(
                  children: <Widget>[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // use here GoogleCircleAvatar
                        Icon(
                          Icons.person_rounded,
                          size: 70,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Adrian Jose Flores',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      'jarc.hydroponics@gmail.com',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.logout_rounded,
                    size: 20,
                  ),
                  label: const Text(
                    'Sign out',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Colors.black.withOpacity(0.85),
                    ),
                  ),
                  onPressed: () {
                    _signOut();
                  },
                ),
                const SizedBox(
                  height: 110,
                )
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.green,
                size: 30,
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightGreenAccent),
                alignment: AlignmentDirectional.center,
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
              onPressed: () => {
                Scaffold.of(context).openEndDrawer(),
              },
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: const MainCanvas(),
    );
  }
}
