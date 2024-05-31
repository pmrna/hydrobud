part of 'chart_data_bloc.dart';

sealed class ChartDataState extends Equatable {
  const ChartDataState();

  @override
  List<Object> get props => [];
}

final class ChartDataInitial extends ChartDataState {}

final class ChartDataLoading extends ChartDataState {}

final class ChartDataFailure extends ChartDataState {
  final String message;
  const ChartDataFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ChartDataLoaded extends ChartDataState {
  final List<Chart> chart;
  const ChartDataLoaded(this.chart);

  @override
  List<Object> get props => [chart];
}
