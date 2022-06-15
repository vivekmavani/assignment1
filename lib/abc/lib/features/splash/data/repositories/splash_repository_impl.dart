import 'package:dartz/dartz.dart';


import '../../../../base/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/splash_data_source.dart';

class SplashRepositoryImpl extends SplashRepository{
final SplashDataSource splashDataSource;

SplashRepositoryImpl({required this.splashDataSource});

  @override
  Future<Either<Failure, void>> firstUser(bool isFirst) async{
    return await splashDataSource.firstUser(isFirst);
  }

  @override
  Future<Either<Failure, bool>> isFirstUser() async{
    return await splashDataSource.isFirstUser();
  }



}