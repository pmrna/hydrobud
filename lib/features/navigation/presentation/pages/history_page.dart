import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/banner_button.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final hasData = true;

  @override
  void initState() {
    // automatically refreshed state of page
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (hasData == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
        child: ListView(
          children: const [
            HeaderText(text: 'History'),
            SizedBox(height: 30),
            BannerButton(),
            SizedBox(height: 30),
          ],
        ),
      );
    } else {
      return _buildNoData();
    }
  }

  Widget _buildNoData() {
    return const Center(
      child: Text('No data available :('),
    );
  }
}
