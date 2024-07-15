import 'package:flutter/material.dart';
import 'package:hydrobud/core/common/widgets/header_text.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/navigation/presentation/widgets/history_banner_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    // automatically refreshed state of page
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('log_data')
        .select('*')
        .order('id', ascending: true);

    debugPrint(response.toString());

    if (mounted) {
      setState(() {
        _data = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const HeaderText(text: 'History'),
          const SizedBox(height: 30),
          Expanded(
            child: _data.isNotEmpty ? _buildBannerButtons() : _buildNoData(),
          )
        ],
      ),
    );
  }

  Widget _buildBannerButtons() {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final dateTime = DateTime.parse(_data[index]['harvest_date']);
        final formattedDate = DateFormat('MMMM d\nyyyy').format(dateTime);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              HistoryBannerButton(
                cropName: _data[index]['crop_name'],
                harvestDate: formattedDate,
                id: _data[index]['id'],
              ),
            ],
          ),
        );
      },
    );
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
