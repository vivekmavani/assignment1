import 'package:assignment1/core/error/failures.dart';
import 'package:assignment1/data/model/characters_model.dart';
import 'package:assignment1/data/model/episodes_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'breaking_data_source.dart';

class BreakingDataSourceImpl implements BreakingDataSource {
  late Dio dio;

  BreakingDataSourceImpl() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://www.breakingbadapi.com/api/",
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  @override
  Future<Either<Failure, List<String>>> getAllSeries() async {
    try {
      Response response = await dio.get('episodes');
      List<dynamic> listOfEpisodesModel = response.data
          .map((values) => EpisodesModel.fromJson(values))
          .toList();
      Set<String> stringSet = {};
      for (var value in listOfEpisodesModel) {
        stringSet.add(value.series!);
      }
      return Right(stringSet.toList());
    } on DioError catch (e) {
      return Left(RemoteFailure());
    }
  }



  @override
  Future<Either<Failure, List<EpisodesModel>>> getEpisodesBySeries(
      String series) async {
    try {
      Response response = await dio.get(
        'episodes',
        queryParameters: {'series': series},
      );
      List<EpisodesModel> list = [];
      for(var item in response.data){
        list.add(EpisodesModel.fromJson(item));
      }

      return Right(list);
    } on DioError catch (e) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharactersModel>>> getCharacters(List<String> characterList) async {
    try {
      Response response = await dio.get(
        'characters',
      );
      List<CharactersModel> list = [];
      for(var item in response.data){
        list.add(CharactersModel.fromJson(item));
      }
      List<CharactersModel> listTwo = [];
      for(var item in characterList){
        for(var itemTwo in list){
          if(itemTwo.name == item){
            listTwo.add(itemTwo);
          }
        }
      }
      return Right(listTwo);
    } on DioError catch (e) {
      return Left(RemoteFailure());
    }
  }
}
