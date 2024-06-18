import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ProgressTimeline extends StatefulWidget {
  const ProgressTimeline({super.key});

  @override
  State<ProgressTimeline> createState() => _ProgressTimelineState();
}

class _ProgressTimelineState extends State<ProgressTimeline> {
  List<Map<String, dynamic>> data = [];

  int _daysUntilHarvest = 0;
  String _harvestDateDisplay = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
    _getDaysUntilHarvest();
  }

  void _fetchData() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('maintained_params')
        .select('created_at, liquid_type')
        .order('created_at', ascending: false);

    debugPrint(response.toString());

    if (mounted) {
      setState(() {
        data = (response as List)
            .map((item) {
              final DateTime createdAt =
                  DateTime.parse(item['created_at']).toLocal();
              final String formattedDate =
                  DateFormat('MM/dd/yyyy\nhh:mm a').format(createdAt);
              final String liquidType =
                  _transformLiquidType(item['liquid_type']);
              return {
                'created_at': formattedDate,
                'liquid_type': liquidType,
              };
            })
            .toList()
            .cast<Map<String, dynamic>>();
      });
    } else {
      if (mounted) {
        setState(() {
          data = [
            {
              'created_at': 'No data',
              'liquid_type': 'No data',
            }
          ];
        });
      }
    }
  }

  String _transformLiquidType(String liquidType) {
    switch (liquidType) {
      case 'pH UP':
        return 'Maintaining pH value';
      // Add more cases as needed for other liquid types
      default:
        return liquidType;
    }
  }

  Future<void> _getDaysUntilHarvest() async {
    final supabase = Supabase.instance.client;
    final response =
        await supabase.from('irrigation_presets').select('transplant_date');

    debugPrint(response.toString());

    final transplantDate = DateTime.parse(response[0]['transplant_date']);
    final harvestDate = transplantDate.add(const Duration(days: 30));

    final timeNow = DateTime.now();

    if (mounted) {
      setState(() {
        _daysUntilHarvest = harvestDate.difference(timeNow).inDays;
        _harvestDateDisplay =
            DateFormat.yMMMMd('en_US').format(harvestDate).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 335,
      decoration: BoxDecoration(
        color: WidgetPallete.greenAccent4,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(1, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_sharp,
                  color: AppPallete.textColorBlack,
                  size: 60,
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_daysUntilHarvest days\nuntil harvest', // not static, should count down the days
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorBlack,
                        height: 1,
                      ),
                    ),
                    Text(
                      _harvestDateDisplay, //depends on transplant date
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textColorBlack3,
                      ),
                    ),
                    // const Spacer(flex: ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 241,
            decoration: const BoxDecoration(
              color: AppPallete.whiteColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: _maintain(),
          ),
        ],
      ),
    );
  }

  Widget _maintain() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                data[index]['created_at'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              Text(
                data[index]['liquid_type'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
