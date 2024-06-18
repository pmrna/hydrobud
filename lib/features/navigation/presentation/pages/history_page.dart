import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/banner_button.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final hasData = false;

  @override
  void initState() {
    // automatically refreshed state of page
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (hasData == true) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: const [
            SizedBox(height: 20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/core/assets/mascot/no_data_mascot.png'),
          ),
          Text(
            'You have no history :(',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppPallete.textColorBlack,
            ),
          ),
          Text(
            'Start harvesting crops to fill\nup this page.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppPallete.textColorGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
