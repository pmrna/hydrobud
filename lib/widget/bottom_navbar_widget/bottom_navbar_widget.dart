import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';
import 'package:hydrobud/pages/home/views/home_canvas.dart';
import 'package:hydrobud/widget/nav_bar_pages/logger_page.dart';
import 'package:hydrobud/widget/nav_bar_pages/analytics_page.dart';
import 'package:hydrobud/widget/nav_bar_pages/irrigation_page.dart';
import 'package:hydrobud/widget/nav_bar_pages/history_page.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  BottomNavBarWidgetState createState() => BottomNavBarWidgetState();
}

class BottomNavBarWidgetState extends State<BottomNavBarWidget>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool _isKeyboardVisible = false;

  static const List<Widget> _pages = <Widget>[
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
        child:
            _selectedIndex == 0 ? const HomeScreen() : _pages[_selectedIndex],
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
              selectedItemColor: onPrimaryColor,
              unselectedItemColor: tertiaryColor,
              backgroundColor: primaryColor,
              selectedLabelStyle: const TextStyle(color: onPrimaryColor),
              unselectedLabelStyle: const TextStyle(color: tertiaryColor),
              onTap: _onItemTapped,
            ),
    );
  }
}
