
import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/core/usecases/usecase.dart';
import 'package:assignment1/domain/entity/characters_entity.dart';
import 'package:assignment1/domain/repository/breaking_repository.dart';
import 'package:dartz/dartz.dart';

class GetCharacterUseCase extends UseCase<List<CharactersEntity>,List<String>>{
  final BreakingRepository breakingRepository;

  GetCharacterUseCase({required this.breakingRepository});

  @override
  Future<Either<Failure, List<CharactersEntity>>?>? call(List<String> params) {
    return breakingRepository.getCharacters(params);
  }


}