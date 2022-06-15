

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/funcation/map_failure_to_message.dart';
import '../../../../route_name.dart';
import '../../domain/usecases/auth_is_sign_in_usecase.dart';
import '../../domain/usecases/auth_with_apple_usecase.dart';
import '../../domain/usecases/auth_with_facebook_usecase.dart';
import '../../domain/usecases/auth_with_google_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthWithGoogleUseCase authWithGoogleUseCase;
  final AuthWithFacebookUseCase authWithFacebookUseCase;
  final AuthWithAppleUseCase authWithAppleUseCase;
  final AuthIsSignInUseCase authIsSignInUseCase;

  AuthCubit(
      {required this.authIsSignInUseCase,
      required this.authWithFacebookUseCase,
      required this.authWithAppleUseCase,
      required this.authWithGoogleUseCase})
      : super(AuthInitial());

  // gotoAuth(BuildContext context) async {
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.signIn, (route) => false);
  // }

  googleAuth() async {
    emit(AuthLoading());
    await authWithGoogleUseCase.authRepository.authWithGoogle().then((value) =>
        value.fold(
            (l) =>  emit(AuthError(message: l.message)), (r) => emit(AuthLoaded(user: r))));
  }

  appleAuth() {
    authWithGoogleUseCase.authRepository.authWithApple().then((value) => value
        .fold((l) => emit(AuthError(message: l.message)), (r) => emit(AuthLoaded(user: r))));
  }

  otpPage() {
    emit(PhoneAuth());
  }

  facebookAuth() {
    authWithGoogleUseCase.authRepository.authWithFacebook().then((value) =>
        value.fold(
            (l) =>  emit(AuthError(message: l.message)), (r) => emit(AuthLoaded(user: r))));
  }

  // isSignIn(context) async {
  //   emit(AuthLoading());
  //   authIsSignInUseCase.authRepository
  //       .authIsSIgnIn()
  //       .then((value) => value.fold((l) => emit(const AuthOrNot(pageName: RoutesName.signIn)), (r) {
  //     if(r){
  //
  //     }else{
  //       emit(const AuthOrNot(pageName: RoutesName.home));
  //     }
  //   }));
  //   if () {
  //     emit(AuthOrNot(
  //         isAuth: await authIsSignInUseCase.authRepository
  //             .authIsSIgnIn()
  //             .then((value) => value.fold((l) => false, (r) => r))));
  //   } else {
  //     debugPrint("home page");
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
  //   }
  // }

  signOut() {
    authIsSignInUseCase.authRepository.authSignOut().then((value) => value.fold(
        (l) =>  emit(AuthError(message: l.message)),
        (r) => emit(UnAuth())));
  }

  getUid() async {
    return await authIsSignInUseCase.authRepository.authGetUid().then((value) =>
        value.fold((l) =>  emit(AuthError(message: l.message)), (r) => r));
  }
}
