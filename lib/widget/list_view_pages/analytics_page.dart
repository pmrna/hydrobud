import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/colors.dart';
import 'package:hydrobud/widget/list_view_pages/analytics_chart/index.dart';
import 'package:hydrobud/widget/list_view_pages/analytics_update_data/index.dart';

class AnalyticsData {
  final int id;
  final String harvestDate;
  final String transplantDate;
  final String cropName;
  final String totalCrops;
  final String totalWeight;
  final String totalSales;

  AnalyticsData({
    required this.id,
    required this.harvestDate,
    required this.transplantDate,
    required this.cropName,
    required this.totalCrops,
    required this.totalWeight,
    required this.totalSales,
  });
}

final supabase = Supabase.instance.client;

final logDataStream = supabase.from('log_data').stream(primaryKey: ['id']);

Future<void> deleteLogData(int noteId) async {
  await supabase.from('log_data').delete().eq('id', noteId.toString());
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Analytics'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 35),
          // const Text(
          //   "COMBINATIONAL CHART, bali bar + line chart",
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          const SizedBox(height: 35),
          const Expanded(child: AnalyticsPageChart()),
          Expanded(
            child: StreamBuilder(
              stream: logDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final List<AnalyticsData> analyticsDataList = snapshot.data!
                    .map((data) => AnalyticsData(
                          id: data['id'] as int,
                          transplantDate: data['transplant_date'] as String,
                          harvestDate: data['harvest_date'] as String,
                          cropName: data['crop_name'] as String,
                          totalCrops: data['total_crops'] as String,
                          totalWeight: data['total_weight'] as String,
                          totalSales: data['total_sales'] as String,
                        ))
                    .toList();

                return ListView.builder(
                  itemCount: analyticsDataList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Edit or Delete?'),
                              content: const Text(
                                'Choose an action to perform',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // Handle edit CODE HERE
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateData(
                                          data: analyticsDataList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle delete CODE HERE
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Delete?'),
                                          content: const Text(
                                            'Are you sure you want to delete this data?',
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Data deleted successfully",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        primaryColor,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                Navigator.of(context).pop();
                                                await deleteLogData(
                                                    analyticsDataList[index]
                                                        .id);
                                              },
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () {
                                // Handle tap CODE HERE
                              },
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Transplant Date: ${analyticsDataList[index].transplantDate}'),
                                    Text(
                                        'Harvested Date: ${analyticsDataList[index].harvestDate}'),
                                    Text(
                                        'Crop Type: ${analyticsDataList[index].cropName}'),
                                    Text(
                                        'Total Crops: ${analyticsDataList[index].totalCrops}'),
                                    Text(
                                        'Total Weight: ${analyticsDataList[index].totalWeight}'),
                                    Text(
                                        'Total Sales: ${analyticsDataList[index].totalSales}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      // rest of codes here
    );
  }
}
