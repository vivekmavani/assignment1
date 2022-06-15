import 'package:dartz/dartz.dart';
import '../../../../base/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class VerifyMobileUseCase extends UseCase<void, String> {
  final AuthRepository authRepository;

  VerifyMobileUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(String params) async =>
      await authRepository.verifyOtp(params);
}
