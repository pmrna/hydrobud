import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrobud/core/usecase/usecase.dart';
import 'package:hydrobud/features/graph/domain/entities/chart.dart';
import 'package:hydrobud/features/graph/domain/usecases/fetch_chart_data.dart';

part 'chart_data_event.dart';
part 'chart_data_state.dart';

class ChartDataBloc extends Bloc<ChartDataEvent, ChartDataState> {
  final FetchChartData _fetchChartData;

  ChartDataBloc({
    required FetchChartData fetchChartData,
  })  : _fetchChartData = fetchChartData,
        super(ChartDataInitial()) {
    on<ChartDataEvent>((event, emit) => emit(ChartDataLoading()));
    on<FetchChartDataEvent>(_onFetchData);
  }

  Future<void> _onFetchData(
    FetchChartDataEvent event,
    Emitter<ChartDataState> emit,
  ) async {
    final data = await _fetchChartData(NoParams());

    data.fold(
      (failure) => emit(ChartDataFailure(failure.message)),
      (chart) => emit(ChartDataLoaded(chart)),
    );
  }
}
