import 'package:hydrobud/core/error/exceptions.dart';
import 'package:hydrobud/features/graph/data/models/chart_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ChartSupabaseSource {
  // Future<ChartDataModel> addChartData(ChartDataModel chart);

  Future<List<ChartDataModel>> fetchChartData();
}

class ChartSupabaseSourceImplementation implements ChartSupabaseSource {
  final SupabaseClient supabaseClient;
  ChartSupabaseSourceImplementation(this.supabaseClient);

  @override
  // Future<ChartDataModel> addChartData(ChartDataModel chart) async {
  //   try {
  //     final data = await supabaseClient.from('sensors').insert(chart.toJson());

  //     return ChartDataModel.fromJson(data.first);
  //   } on PostgrestException catch (e) {
  //     throw ServerException(e.message);
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  @override
  Future<List<ChartDataModel>> fetchChartData() async {
    try {
      final data = await supabaseClient
          .from('sensors')
          .select('sensor_name, value, time');

      return data
          .map<ChartDataModel>((item) => ChartDataModel.fromJson(item))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
