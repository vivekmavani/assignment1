import 'package:dartz/dartz.dart';

import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class AuthGetUidUseCase extends UseCase<String, NoParams> {
  final AuthRepository authRepository;

  AuthGetUidUseCase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await authRepository.authGetUid();
}
