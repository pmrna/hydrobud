import 'package:flutter/material.dart';
import 'package:hydrobud/widget/list_view_pages/analytics_page.dart';
import 'package:hydrobud/widget/list_view_pages/irrigation_page.dart';
import 'package:hydrobud/widget/list_view_pages/logger_page.dart';

class CardItem {
  final String listViewImage;
  final String title;
  final Widget page;

  const CardItem({
    required this.listViewImage,
    required this.title,
    required this.page,
  });
}

class HorizontalListView extends StatefulWidget {
  const HorizontalListView({Key? key}) : super(key: key);

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  List<CardItem> items = [
    const CardItem(
      title: 'Analytics',
      listViewImage: 'assets/logo/analytics_logo.jpg',
      page: AnalyticsPage(),
    ),
    const CardItem(
      title: 'Irrigation',
      listViewImage: 'assets/logo/irrigation_logo.jpg',
      page: IrrigationPage(),
    ),
    const CardItem(
      title: 'Logger',
      listViewImage: 'assets/logo/logger_logo.jpg',
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
            SizedBox(height: 50), // Adjust spacing here
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, _) => SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    buildCard(context, item: items[index]),
              ),
            ),
          ],
        ),
      );

  Widget buildCard(BuildContext context, {required CardItem item}) => Container(
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
                      image: AssetImage(item.listViewImage),
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
            SizedBox(height: 4),
            Text(
              item.title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
}
