// import 'package:fpdart/fpdart.dart';
// import 'package:hydrobud/core/error/failures.dart';
// import 'package:hydrobud/core/usecase/usecase.dart';
// import 'package:hydrobud/features/graph/domain/entities/chart.dart';
// import 'package:hydrobud/features/graph/domain/repositories/chart_repository.dart';

// class AddChartData implements UseCase<Chart, AddChartDataParams> {
//   final ChartRepository chartRepository;
//   AddChartData(this.chartRepository);

//   @override
//   Future<Either<Failure, Chart>> call(AddChartDataParams params) async {
//     return await chartRepository.addChartData(
//       id: params.label,
//       label: params.label,
//       value: params.value,
//       time: params.time,
//     );
//   }
// }

// class AddChartDataParams {
//   final String id;
//   final String label;
//   final double value;
//   final DateTime time;

//   AddChartDataParams({
//     required this.id,
//     required this.label,
//     required this.value,
//     required this.time,
//   });
// }
