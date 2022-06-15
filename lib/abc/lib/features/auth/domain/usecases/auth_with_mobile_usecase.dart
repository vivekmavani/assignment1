import 'package:dartz/dartz.dart';
import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class AuthWithMobileUseCase extends UseCase<void, String> {
  final AuthRepository authRepository;

  AuthWithMobileUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(String params) async =>
      await authRepository.authWithMobile(params);
}
