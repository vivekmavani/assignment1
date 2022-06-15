

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixtystrong/features/home/presentation/pages/home_page.dart';
import 'package:sixtystrong/features/splash/presentation/cubit/splash_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/phone_auth_cubit.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/injection_container.dart' as di;
import 'features/intro/presentation/page/intro_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'route_name.dart';

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {

      switch (settings.name) {
        case RoutesName.splash:
          return MaterialPageRoute(builder: (_) {
            return  BlocProvider(
              create: (_) => di.sl<SplashCubit>(),
              child: const SplashPage(),
            );
          });

        case RoutesName.signIn:
          return MaterialPageRoute(builder: (_) {
            return   MultiBlocProvider(
              providers: [
                BlocProvider<AuthCubit>(
                  create: (_) => di.sl<AuthCubit>(),
                ),
                BlocProvider<PhoneAuthCubit>(
                  create: (BuildContext context)=> di.sl<PhoneAuthCubit>(),
                ),
              ],
              child: const AuthPage(),
            );
          });
        // case RoutesName.otp:
        //   return MaterialPageRoute(builder: (_) {
        //     return  BlocProvider(
        //       create: (context) => di.sl<AuthCubit>(),
        //       child: const SplashPage(),
        //     );
        //   });

        case RoutesName.intro:
          return MaterialPageRoute(builder: (_) {
            return BlocProvider(
              create: (_) => di.sl<AuthCubit>(),
              child: const IntroPage(),
            );
          });

        case RoutesName.home:
          return MaterialPageRoute(builder: (_) {
            return   BlocProvider(
              create: (_) => di.sl<AuthCubit>(),
              child: const HomePage(),
            );
          });




        default:
          return MaterialPageRoute(builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          });
      }
    }
}