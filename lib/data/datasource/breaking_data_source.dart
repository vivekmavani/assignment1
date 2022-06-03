import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/data/model/characters_model.dart';
import 'package:assignment1/data/model/episodes_model.dart';
import 'package:dartz/dartz.dart';

abstract class BreakingDataSource{
  Future<Either<Failure,List<String>>> getAllSeries();
  Future<Either<Failure,List<EpisodesModel>>> getEpisodesBySeries(String series);
  Future<Either<Failure,List<CharactersModel>>> getCharacters(List<String> characterList);
}