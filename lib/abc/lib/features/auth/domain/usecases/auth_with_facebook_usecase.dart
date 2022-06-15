import 'package:dartz/dartz.dart';
import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class AuthWithFacebookUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  AuthWithFacebookUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async =>
      await authRepository.authWithFacebook();
}
