import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';
import 'package:hydrobud/widget/quick_access_widget/quick_access_widget.dart';
import 'package:hydrobud/widget/horizontal_list_view/index.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  State<MainCanvas> createState() => _MainCanvasState();
}

class _MainCanvasState extends State<MainCanvas> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Column(
          children: [
            Row(
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
            const SizedBox(height: 10),
            const Expanded(
              child: HorizontalListView(),
            ),
          ],
        ),
      ),
    );
  }
}
