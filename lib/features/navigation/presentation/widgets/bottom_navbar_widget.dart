import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 3,
          blurStyle: BlurStyle.outer,
          spreadRadius: 1,
          offset: Offset(0, 2),
        ),
      ]),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('lib/core/assets/icons/dashboard_icon.png'),
              color: widget.selectedIndex == 0
                  ? AppPallete.focusColor
                  : AppPallete.unfocusColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('lib/core/assets/icons/history_icon.png'),
              color: widget.selectedIndex == 1
                  ? AppPallete.focusColor
                  : AppPallete.unfocusColor,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('lib/core/assets/icons/irrigation_icon.png'),
              color: widget.selectedIndex == 2
                  ? AppPallete.focusColor
                  : AppPallete.unfocusColor,
            ),
            label: 'Irrigation',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('lib/core/assets/icons/analytics_icon.png'),
              color: widget.selectedIndex == 3
                  ? AppPallete.focusColor
                  : AppPallete.unfocusColor,
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: widget.selectedIndex == 4
                  ? AppPallete.focusColor
                  : AppPallete.unfocusColor,
            ),
            label: 'Logger',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: AppPallete.focusColor,
        unselectedItemColor: AppPallete.unfocusColor,
        selectedLabelStyle: const TextStyle(color: AppPallete.focusColor),
        unselectedLabelStyle: const TextStyle(color: AppPallete.unfocusColor),
        onTap: widget.onItemTapped,
      ),
    );
  }
}
