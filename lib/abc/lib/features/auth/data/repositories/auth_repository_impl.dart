import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../base/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

class AuthRepositoryImpl extends AuthRepository{
final AuthDataSource authDataSource;

AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, String>> authGetUid() async{
    return await authDataSource.authGetUid();
  }

  @override
  Future<Either<Failure, bool>> authIsSIgnIn() async{
    return await authDataSource.authIsSIgnIn();
  }

  @override
  Future<Either<Failure, void>> authSignOut() async{
    return await authDataSource.authSignOut();
  }

  @override
  Future<Either<Failure, User>> authWithApple() async{
    return await authDataSource.authWithApple();
  }

  @override
  Future<Either<Failure, User>> authWithFacebook() async{
    return await authDataSource.authWithFacebook();
  }

  @override
  Future<Either<Failure, User>> authWithGoogle() async{
    return await authDataSource.authWithGoogle();
  }

  @override
  Future<Either<Failure, void>> authWithMobile(String mobile)async {
    return await authDataSource.authWithMobile(mobile);
  }

  @override
  Future<Either<Failure, void>> firstUser(bool isFirst) async{
    return await authDataSource.firstUser(isFirst);
  }

  @override
  Future<Either<Failure, bool>> isFirstUser() async{
    return await authDataSource.isFirstUser();
  }

  @override
  Future<Either<Failure, User>> verifyOtp(String otp)async {
    return await authDataSource.verifyOtp(otp);
  }

}