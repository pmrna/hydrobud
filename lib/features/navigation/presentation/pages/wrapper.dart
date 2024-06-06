import 'package:flutter/material.dart';
import 'package:hydrobud/features/maintain/presentation/pages/maintain_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/analytics_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/dashboard_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/history_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/irrigation_page.dart';
import 'package:hydrobud/features/navigation/presentation/pages/logger_page.dart';
import 'package:hydrobud/features/navigation/presentation/widgets/bottom_navbar_widget.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const DashboardPage(),
      const HistoryPage(),
      IrrigationPage(onFabPressed: _changeToMaintainPage),
      const AnalyticsPage(),
      const LoggerPage(),
    ];
  }

  void _changeToMaintainPage() {
    setState(() {
      _pages[2] = MaintainPage(
        onFabPressed: _changeToIrrigationPage,
      );
      _selectedIndex = 2;
    });
  }

  void _changeToIrrigationPage() {
    setState(() {
      _pages[2] = IrrigationPage(onFabPressed: _changeToMaintainPage);
      _selectedIndex = 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Hydrobud',
          style: TextStyle(fontFamily: 'BobbyJones', fontSize: 32),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 12,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/core/assets/mascot/mascot.png'),
              radius: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
