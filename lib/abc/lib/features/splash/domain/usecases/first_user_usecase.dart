import 'package:dartz/dartz.dart';


import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class FirstUserUseCase extends UseCase<void, bool> {
  final SplashRepository splashRepository;

  FirstUserUseCase({required this.splashRepository});

  @override
  Future<Either<Failure, void>> call(bool params) async =>
      await splashRepository.firstUser(params);
}
