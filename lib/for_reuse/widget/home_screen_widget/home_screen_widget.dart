import 'package:flutter/material.dart';
import 'package:hydrobud/for_reuse/constants/colors.dart';
import 'package:hydrobud/features/navigation/presentation/pages/logger_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/analytics_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/irrigation_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/history_page.dart';
import 'package:hydrobud/for_reuse/widget/quick_access_widget/quick_access_widget.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  MainCanvasState createState() => MainCanvasState();
}

class MainCanvasState extends State<MainCanvas> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool _isKeyboardVisible = false;

  static List<Widget> _pages = <Widget>[
    Placeholder(),
    HistoryPage(),
    IrrigationPage(),
    AnalyticsPage(),
    LoggerPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final isKeyboardVisible =
        // ignore: deprecated_member_use
        WidgetsBinding.instance.window.viewInsets.bottom > 0;
    if (isKeyboardVisible != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = isKeyboardVisible;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _selectedIndex == 0
            ? _buildMainCanvasContent(context)
            : _pages[_selectedIndex],
      ),
      bottomNavigationBar: _isKeyboardVisible
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.water_drop_outlined),
                  label: 'Irrigation',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics),
                  label: 'Analytics',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Logger',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: primaryColor,
              unselectedItemColor: tertiaryColor,
              backgroundColor: onPrimaryColor,
              selectedLabelStyle: const TextStyle(color: primaryColor),
              unselectedLabelStyle: const TextStyle(color: tertiaryColor),
              onTap: _onItemTapped,
            ),
    );
  }

  Widget _buildMainCanvasContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            const SizedBox(
              height: 20,
            ),
            const QuickAccessWidget(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.water,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Water Quality',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
