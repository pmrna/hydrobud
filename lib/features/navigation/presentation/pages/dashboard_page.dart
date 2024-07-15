import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/core/common/widgets/banner_button.dart';
import 'package:hydrobud/features/navigation/presentation/widgets/home_graph_container.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/common/widgets/headings_text.dart';
import 'package:hydrobud/features/navigation/presentation/widgets/home_quick_start_banner_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isOngoing = false;
  String _cropName = '';

  @override
  void initState() {
    super.initState();
    _setValuesFromDB();
  }

  Future<void> _setValuesFromDB() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('irrigation_presets')
        .select('is_ongoing, crop_name')
        .eq('id', 1);

    if (mounted) {
      setState(() {
        _isOngoing = response[0]['is_ongoing'];
        _cropName = response[0]['crop_name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const HeaderText(text: 'Dashboard'),
        const SizedBox(height: 20),
        const HeadingsText(
          mainText: 'Hello, \n',
          subText: 'Adrian.',
          mainSize: 22,
          subSize: 24,
          mainColor: AppPallete.textColorBlack2,
          subColor: AppPallete.textColorGreen,
        ),
        const SizedBox(height: 25),
        const HeadingsText(
          mainText: "Here's your update for today...",
          mainSize: 16,
          mainColor: AppPallete.textColorBlack,
        ),
        const SizedBox(height: 10),
        _isOngoing
            ? BannerButton(cropName: _cropName)
            : const QuickStartBannerButton(),
        const SizedBox(height: 25),
        const HomeGraphContainer(),
      ],
    );
  }
}
