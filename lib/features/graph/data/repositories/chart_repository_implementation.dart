import 'package:fpdart/fpdart.dart';
import 'package:hydrobud/core/error/exceptions.dart';
import 'package:hydrobud/core/error/failures.dart';
import 'package:hydrobud/features/graph/data/datasources/chart_supabase_source.dart';
// import 'package:hydrobud/features/graph/data/models/chart_model.dart';
import 'package:hydrobud/features/graph/domain/entities/chart.dart';
import 'package:hydrobud/features/graph/domain/repositories/chart_repository.dart';

class ChartRepositoryImplementation implements ChartRepository {
  final ChartSupabaseSource chartSupabaseSource;

  ChartRepositoryImplementation(
    this.chartSupabaseSource,
  );

  // @override
  // Future<Either<Failure, Chart>> addChartData({
  //   required String id,
  //   required String label,
  //   required double value,
  //   required DateTime time,
  // }) async {
  //   try {
  //     ChartDataModel chartModel = ChartDataModel(
  //       id: id,
  //       label: label,
  //       value: value,
  //       time: DateTime.now(),
  //     );

  //     final addedData = await chartSupabaseSource.addChartData(chartModel);
  //     return right(addedData);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, List<Chart>>> fetchChartData() async {
    try {
      final chartData = await chartSupabaseSource.fetchChartData();
      return right(chartData);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
