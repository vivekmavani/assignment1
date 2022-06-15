import 'package:get_it/get_it.dart';
import 'package:sixtystrong/features/splash/data/datasources/splash_data_source.dart';
import 'package:sixtystrong/features/splash/data/datasources/splash_data_source_impl.dart';
import 'package:sixtystrong/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:sixtystrong/features/splash/domain/repositories/auth_repository.dart';
import 'package:sixtystrong/features/splash/presentation/cubit/splash_cubit.dart';

import 'auth/data/datasources/auth_data_source.dart';
import 'auth/data/datasources/auth_data_source_impl.dart';
import 'auth/data/repositories/auth_repository_impl.dart';
import 'auth/domain/repositories/auth_repository.dart';
import 'auth/domain/usecases/auth_is_sign_in_usecase.dart';
import 'auth/domain/usecases/auth_with_apple_usecase.dart';
import 'auth/domain/usecases/auth_with_facebook_usecase.dart';
import 'auth/domain/usecases/auth_with_google_usecase.dart';
import 'auth/domain/usecases/auth_with_mobile_usecase.dart';
import 'auth/presentation/cubit/auth_cubit.dart';
import 'splash/domain/usecases/first_user_usecase.dart';
import 'splash/domain/usecases/is_first_user_usecase.dart';
import 'auth/domain/usecases/verify_mobile_usecase.dart';
import 'auth/presentation/cubit/phone_auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(
    () => AuthCubit(
        authWithFacebookUseCase: sl(),
        authIsSignInUseCase: sl(),
        authWithAppleUseCase: sl(),
        authWithGoogleUseCase: sl(),),
  );
  sl.registerFactory(
    () =>
        PhoneAuthCubit(verifyMobileUseCase: sl(), authWithMobileUseCase: sl(),authIsSignInUseCase: sl()),
  );

  sl.registerFactory(
        () => SplashCubit(
      authIsSignInUseCase: sl(), firstUserUseCase: sl(), isFirstUserUseCase: sl(),),
  );

  // Use cases
  sl.registerLazySingleton(() => AuthWithFacebookUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => AuthIsSignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => AuthWithAppleUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => AuthWithGoogleUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => FirstUserUseCase(splashRepository: sl()));
  sl.registerLazySingleton(() => IsFirstUserUseCase(splashRepository: sl()));
  sl.registerLazySingleton(() => VerifyMobileUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => AuthWithMobileUseCase(authRepository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl()),
  );
  sl.registerLazySingleton<SplashRepository>(
        () => SplashRepositoryImpl(splashDataSource: sl()),
  );
  // Data sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(),
  );
  sl.registerLazySingleton<SplashDataSource>(
        () => SplashDataSourceImpl(),
  );
}
