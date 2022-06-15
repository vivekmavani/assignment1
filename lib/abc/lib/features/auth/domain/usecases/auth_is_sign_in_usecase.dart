import 'package:dartz/dartz.dart';
import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';


class AuthIsSignInUseCase extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  AuthIsSignInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async =>
      await authRepository.authIsSIgnIn();
}
