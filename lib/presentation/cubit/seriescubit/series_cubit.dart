import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/core/funcation/map_failure_to_message.dart';
import 'package:assignment1/domain/usecase/get_all_series_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  final GetAllSeriesUseCase getAllSeriesUseCase;

  SeriesCubit({required this.getAllSeriesUseCase}) : super(SeriesInitial());

  getSeries() async {
    emit(SeriesLoading());
    final Future<Either<Failure, List<String>>> tripHistoryList =
        getAllSeriesUseCase.breakingRepository.getAllSeries();
    tripHistoryList.then((value) {
      value.fold(
          (l) =>  emit(SeriesFailed(mapFailureToMessage(l))), (r) => emit(SeriesLoaded(r)));
    });
  }
}
