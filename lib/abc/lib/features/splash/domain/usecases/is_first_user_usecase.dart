import 'package:dartz/dartz.dart';


import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class IsFirstUserUseCase extends UseCase<bool, NoParams> {
  final SplashRepository splashRepository;

  IsFirstUserUseCase({required this.splashRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async =>
      await splashRepository.isFirstUser();
}
