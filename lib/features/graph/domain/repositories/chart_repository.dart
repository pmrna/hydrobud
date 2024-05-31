import 'package:fpdart/fpdart.dart';
import 'package:hydrobud/core/error/failures.dart';
import 'package:hydrobud/features/graph/domain/entities/chart.dart';

abstract class ChartRepository {
  // Future<Either<Failure, Chart>> addChartData({
  //   required String id,
  //   required String label,
  //   required double value,
  //   required DateTime time,
  // });

  Future<Either<Failure, List<Chart>>> fetchChartData();
}
