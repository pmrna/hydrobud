import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';
import 'package:hydrobud/widget/nav_bar_pages/logger_page.dart';
import 'package:hydrobud/widget/nav_bar_pages/analytics_page.dart';
import 'package:hydrobud/widget/nav_bar_pages/irrigation_page.dart';
import 'package:hydrobud/widget/nav_bar_pages/history_page.dart';
import 'package:hydrobud/widget/quick_access_widget/quick_access_widget.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  MainCanvasState createState() => MainCanvasState();
}

class MainCanvasState extends State<MainCanvas> with WidgetsBindingObserver {
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
              selectedItemColor: onPrimaryColor,
              unselectedItemColor: tertiaryColor,
              backgroundColor: primaryColor,
              selectedLabelStyle: const TextStyle(color: onPrimaryColor),
              unselectedLabelStyle: const TextStyle(color: tertiaryColor),
              onTap: _onItemTapped,
            ),
    );
  }

  Widget _buildMainCanvasContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[700],
                        ),
                      ),
                      Icon(
                        Icons.person_rounded,
                        color: outlineHighlightColor,
                        size: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: outlineHighlightColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu_rounded),
              ),
            ],
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
    );
  }
}
