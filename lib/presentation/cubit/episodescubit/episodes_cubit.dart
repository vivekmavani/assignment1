import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/core/funcation/map_failure_to_message.dart';
import 'package:assignment1/domain/entity/characters_entity.dart';
import 'package:assignment1/domain/entity/episodes_entity.dart';
import 'package:assignment1/domain/usecase/get_characters_usecase.dart';
import 'package:assignment1/domain/usecase/get_episodes_by_series_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'episodes_state.dart';

class EpisodesCubit extends Cubit<EpisodesState> {
  final GetEpisodesBySeriesUSeCase getEpisodesBySeriesUSeCase;
  final GetCharacterUseCase getCharacterUseCase;
  EpisodesCubit({required this.getEpisodesBySeriesUSeCase,required this.getCharacterUseCase})
      : super(EpisodesInitial());

  getEpisodes(String name) async {
    emit(EpisodesLoading());
    final Future<Either<Failure, List<EpisodesEntity>>> charactersEntity =
    getEpisodesBySeriesUSeCase.breakingRepository.getEpisodesBySeries(name);
    charactersEntity.then((value) {
      value.fold((l) => emit(EpisodesFailed(mapFailureToMessage(l))),
              (r) =>emit(EpisodesLoaded(r)));
    });
  }
  getCharacterList(List<String> list) async {
    emit(EpisodesLoading());
    final Future<Either<Failure, List<CharactersEntity>>> charactersEntity =
    getCharacterUseCase.breakingRepository.getCharacters(list);
    charactersEntity.then((value) {
      value.fold((l) => emit(EpisodesFailed(mapFailureToMessage(l))),
              (r) =>emit(EpisodesLoaded(r)));
    });
  }
}
