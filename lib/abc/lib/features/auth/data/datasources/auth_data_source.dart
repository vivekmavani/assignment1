import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../base/error/failures.dart';




abstract class AuthDataSource{
  Future<Either<Failure,bool>> authIsSIgnIn();
  Future<Either<Failure,String>> authGetUid();
  Future<Either<Failure,void>> authSignOut();
  Future<Either<Failure,User>> authWithGoogle();
  Future<Either<Failure,void>> authWithMobile(String mobile);
  Future<Either<Failure,User>> verifyOtp(String otp);
  Future<Either<Failure,User>> authWithApple();
  Future<Either<Failure,User>> authWithFacebook();
  Future<Either<Failure,void>> firstUser(bool isFirst);
  Future<Either<Failure,bool>> isFirstUser();
}