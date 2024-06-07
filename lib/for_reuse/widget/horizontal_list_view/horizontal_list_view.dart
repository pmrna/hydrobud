// import 'package:flutter/material.dart';
// import 'package:hydrobud/features/navigation/presentation/pages/analytics_page.dart';
// import 'package:hydrobud/features/navigation/presentation/pages/irrigation_page.dart';
// import 'package:hydrobud/features/navigation/presentation/pages/logger_page.dart';

// class CardItem {
//   final String listViewImage;
//   final String title;
//   final Widget page;

//   const CardItem({
//     required this.listViewImage,
//     required this.title,
//     required this.page,
//   });
// }

// class HorizontalListView extends StatefulWidget {
//   const HorizontalListView({super.key});

//   @override
//   State<HorizontalListView> createState() => _HorizontalListViewState();
// }

// class _HorizontalListViewState extends State<HorizontalListView> {
//   List<CardItem> items = [
//     const CardItem(
//       title: 'Analytics',
//       listViewImage: 'lib/core/assets/images/analytics_logo.jpg',
//       page: AnalyticsPage(),
//     ),
//     CardItem(
//       title: 'Irrigation',
//       listViewImage: 'assets/logo/irrigation_bg.jpg',
//       page: IrrigationPage(),
//     ),
//     const CardItem(
//       title: 'Logger',
//       listViewImage: 'assets/logo/logger_bg.jpg',
//       page: LoggerPage(),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: Text(
//             "List",
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//               color: Theme.of(context).colorScheme.outline,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         extendBodyBehindAppBar: true,
//         body: Column(
//           children: [
//             const SizedBox(height: 50), // Adjust spacing here
//             SizedBox(
//               height: 150,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: items.length,
//                 separatorBuilder: (context, _) => const SizedBox(width: 12),
//                 itemBuilder: (context, index) =>
//                     buildCard(context, item: items[index]),
//               ),
//             ),
//           ],
//         ),
//       );

//   Widget buildCard(BuildContext context, {required CardItem item}) => SizedBox(
//         width: 160,
//         child: Column(
//           children: [
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 4 / 3,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Material(
//                     child: Ink.image(
//                       image: AssetImage(item.listViewImage),
//                       fit: BoxFit.cover,
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => item.page,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               item.title,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       );
// }
