import 'package:flutter/material.dart';
import 'package:hydrobud/constants/colors.dart';
import 'package:hydrobud/widget/quick_access_widget.dart';
import 'package:hydrobud/widget/horizontal_list_view.dart';

class MainCanvas extends StatelessWidget {
  const MainCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                    SizedBox(
                        width: 10
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
                IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            QuickAccessWidget(),
            SizedBox(
              height: 20,
            ),
            Row(            // dito mag start
              children: [
                Icon(
                  Icons.water,
                  size: 20,
                ),
                SizedBox(
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
            SizedBox(
                height: 10
            ),
            Expanded(
                child:HorizontalListView(),
            ),
          ],
        ),
      ),
    );


  }
}
