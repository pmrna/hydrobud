import 'package:fpdart/fpdart.dart';
import 'package:hydrobud/core/error/failures.dart';
import 'package:hydrobud/core/usecase/usecase.dart';
import 'package:hydrobud/features/graph/domain/entities/chart.dart';
import 'package:hydrobud/features/graph/domain/repositories/chart_repository.dart';

class FetchChartData implements UseCase<List<Chart>, NoParams> {
  final ChartRepository chartRepository;
  FetchChartData(this.chartRepository);

  @override
  Future<Either<Failure, List<Chart>>> call(NoParams params) async {
    return await chartRepository.fetchChartData();
  }
}
