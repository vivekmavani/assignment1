import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixtystrong/route_name.dart';

import '../../../auth/domain/usecases/auth_is_sign_in_usecase.dart';
import '../../domain/usecases/first_user_usecase.dart';
import '../../domain/usecases/is_first_user_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final FirstUserUseCase firstUserUseCase;
  final IsFirstUserUseCase isFirstUserUseCase;
  final AuthIsSignInUseCase authIsSignInUseCase;
  SplashCubit({required this.authIsSignInUseCase, required this.firstUserUseCase,required this.isFirstUserUseCase}) : super(SplashInitial());
  firstUser()async{
    await firstUserUseCase.splashRepository.firstUser(false);
  }
  isFirstUser(BuildContext context,mounted)async{
    String route;
    if(await firstUserUseCase.splashRepository.isFirstUser().then((value) => value.fold((l) => false,
            (r) =>r))){
      await firstUser();
      route = RoutesName.intro;
    }else if(await authIsSignInUseCase.authRepository.authIsSIgnIn().then((value) => value.fold((l) => false,
            (r) =>r))){
      route = RoutesName.home;
    }else{
      route = RoutesName.signIn;
    }
    if (!mounted) return;
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushNamedAndRemoveUntil(context, route, (route) => false)
    );
  }
}
