

import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/domain/entity/characters_entity.dart';
import 'package:assignment1/domain/entity/episodes_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BreakingRepository {
  Future<Either<Failure,List<String>>> getAllSeries();
  Future<Either<Failure,List<EpisodesEntity>>> getEpisodesBySeries(String series);
  Future<Either<Failure,List<CharactersEntity>>> getCharacters(List<String> characterList);
}