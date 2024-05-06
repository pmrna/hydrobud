import 'package:flutter/material.dart';
import 'package:hydrobud/widget/list_view_pages/analytics_chart/analytics_chart_widget.dart';
import '../../constants/colors.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Define a list of data
    List<AnalyticsData> analyticsDataList = [
      AnalyticsData(
        month: "January",
        cropType: "Tomato",
        harvestedCropCount: 150,
        totalWeight: 500,
        totalSales: 750,
      ),
      AnalyticsData(
        month: "February",
        cropType: "Potato",
        harvestedCropCount: 200,
        totalWeight: 600,
        totalSales: 900,
      ),
      // Add more data for other months
    ];

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
          const Text(
            "COMBINATIONAL CHART, bali bar + line chart",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 35),
          const Expanded(child: AnalyticsPageChart()),
          Expanded(
            child: ListView.builder(
              itemCount: analyticsDataList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Month: ${analyticsDataList[index].month}'),
                        Text('Crop Type: ${analyticsDataList[index].cropType}'),
                        Text(
                            'Total Crops ${analyticsDataList[index].harvestedCropCount}'),
                        Text(
                            'Total Weight: ${analyticsDataList[index].totalWeight}'),
                        Text(
                            'Total Sales: ${analyticsDataList[index].totalSales}'),
                      ],
                    ),
                  ),
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

// Define a class to represent each item in the list
class AnalyticsData {
  final String month;
  final String cropType;
  final int harvestedCropCount;
  final double totalWeight;
  final double totalSales;

  AnalyticsData({
    required this.month,
    required this.cropType,
    required this.harvestedCropCount,
    required this.totalWeight,
    required this.totalSales,
  });
}
