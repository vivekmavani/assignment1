import 'package:dartz/dartz.dart';

import '../../../../base/error/failures.dart';


abstract class SplashRepository{
  Future<Either<Failure,void>> firstUser(bool isFirst);
  Future<Either<Failure,bool>> isFirstUser();
}