
import 'package:assignment1/presentation/cubit/episodescubit/episodes_cubit.dart';
import 'package:assignment1/presentation/cubit/seriescubit/series_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/datasource/breaking_data_source.dart';
import 'data/datasource/breaking_data_source_impl.dart';
import 'data/repository/breaking_repository_impl.dart';
import 'domain/repository/breaking_repository.dart';
import 'domain/usecase/get_all_series_usecase.dart';
import 'domain/usecase/get_characters_usecase.dart';
import 'domain/usecase/get_episodes_by_series_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(
        () => SeriesCubit(
          getAllSeriesUseCase: sl(),
    ),
  );
  sl.registerFactory(
        () => EpisodesCubit(
      getEpisodesBySeriesUSeCase: sl(),
          getCharacterUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllSeriesUseCase(breakingRepository: sl()));
  sl.registerLazySingleton(() => GetEpisodesBySeriesUSeCase(breakingRepository: sl()));
  sl.registerLazySingleton(() => GetCharacterUseCase(breakingRepository: sl()));

  // Repository
  sl.registerLazySingleton<BreakingRepository>(
        () => BreakingRepositoryImpl(breakingDataSource: sl()
    ),
  );
  // Data sources
  sl.registerLazySingleton<BreakingDataSource>(
        () => BreakingDataSourceImpl(),
  );
}