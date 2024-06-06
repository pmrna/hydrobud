import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/core/common/widgets/banner_button.dart';
import 'package:hydrobud/features/navigation/presentation/widgets/home_graph_container.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/common/widgets/headings_text.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
      children: const [
        HeaderText(text: 'Dashboard'),
        SizedBox(height: 20),
        HeadingsText(
          mainText: 'Hello, \n',
          subText: 'Adrian.',
          mainSize: 22,
          subSize: 24,
          mainColor: AppPallete.textColorBlack2,
          subColor: AppPallete.textColorGreen,
        ),
        SizedBox(height: 25),
        HeadingsText(
          mainText: "Here's your update for today...",
          mainSize: 16,
          mainColor: AppPallete.textColorBlack,
        ),
        SizedBox(height: 10),
        BannerButton(),
        SizedBox(height: 25),
        HomeGraphContainer(),
      ],
    );
  }
}
