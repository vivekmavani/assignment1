import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/core/usecases/usecase.dart';
import 'package:assignment1/domain/entity/episodes_entity.dart';
import 'package:assignment1/domain/repository/breaking_repository.dart';
import 'package:dartz/dartz.dart';

class GetEpisodesBySeriesUSeCase extends UseCase<List<EpisodesEntity>,String>{
  final BreakingRepository breakingRepository;

  GetEpisodesBySeriesUSeCase({required this.breakingRepository});

  @override
  Future<Either<Failure,List<EpisodesEntity>>?>? call(String params){
    return breakingRepository.getEpisodesBySeries(params);
  }
}