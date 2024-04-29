import 'package:flutter/material.dart';
import 'package:hydrobud/widget/list_view_pages/AnalyticsPage.dart';
import 'package:hydrobud/widget/list_view_pages/IrrigationPage.dart';
import 'package:hydrobud/widget/list_view_pages/LoggerPage.dart';

class CardItem {
  final String urlImage;
  final String title;
  final Widget page;

  const CardItem({
    required this.urlImage,
    required this.title,
    required this.page,
  });
}

class HorizontalListView extends StatefulWidget {
  const HorizontalListView({super.key});

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  List<CardItem> items = [
    const CardItem(
      title: 'Analytics',
      urlImage:
      'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      page: AnalyticsPage(),
    ),
    const CardItem(
      title: 'Irrigation',
      urlImage:
      'https://images.unsplash.com/photo-1515150144380-bca9f1650ed9?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      page: IrrigationPage(),
    ),
    const CardItem(
      title: 'Logger',
      urlImage:
      'https://images.unsplash.com/photo-1483546416237-76fd26bbcdd1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      page: LoggerPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "List",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      centerTitle: true,
    ),
    extendBodyBehindAppBar: true,
    body: Column(
      children: [
        const SizedBox(height: 50), // Adjust spacing here
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) =>
                buildCard(context, item: items[index]),
          ),
        ),
      ],
    ),
  );

  Widget buildCard(BuildContext context, {required CardItem item}) => SizedBox(
    width: 160,
    child: Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                child: Ink.image(
                  image: NetworkImage(item.urlImage),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => item.page,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          item.title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
