part of 'chart_data_bloc.dart';

sealed class ChartDataEvent extends Equatable {
  const ChartDataEvent();

  @override
  List<Object> get props => [];
}

class FetchChartDataEvent extends ChartDataEvent {}
