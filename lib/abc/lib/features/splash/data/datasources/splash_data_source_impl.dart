

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sixtystrong/base/error/failures.dart';
import 'package:sixtystrong/features/splash/data/datasources/splash_data_source.dart';

import '../../../../core/hive_helper.dart';
class SplashDataSourceImpl extends SplashDataSource {
   Box? box;


  @override
  Future<Either<Failure,void>> firstUser(bool isFirst) async {
    try{
      if (!HiveHelper().isBoxOpen()) {
        await HiveHelper().open();
      }
      Box myBox = await HiveHelper().myBox();
      return Right(myBox.put('isFirst', isFirst));
    }on Exception catch(e){
      debugPrint(e.toString());
      return Left(CacheFailure());
    }

  }

  @override
  Future<Either<Failure,bool>> isFirstUser() async {
    try{
      if (!HiveHelper().isBoxOpen()) {
        await HiveHelper().open();
      }
      Box myBox = await HiveHelper().myBox();
      return Right(myBox.get('isFirst', defaultValue: true));
    }catch(e){
      debugPrint(e.toString());
      return Left(CacheFailure());
    }
  }
}
