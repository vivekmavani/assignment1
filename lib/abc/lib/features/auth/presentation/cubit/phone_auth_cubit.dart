

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/funcation/snack_bar.dart';
import '../../../../route_name.dart';
import '../../domain/usecases/auth_is_sign_in_usecase.dart';
import '../../domain/usecases/auth_with_mobile_usecase.dart';
import '../../domain/usecases/verify_mobile_usecase.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final VerifyMobileUseCase verifyMobileUseCase;
  final AuthWithMobileUseCase authWithMobileUseCase;
  final AuthIsSignInUseCase authIsSignInUseCase;

  PhoneAuthCubit(
      {required this.authIsSignInUseCase,
      required this.authWithMobileUseCase,
      required this.verifyMobileUseCase})
      : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    emit(PhoneAuthLoading());
    await authWithMobileUseCase.call(phoneNumber).then((value) => value.fold(
        (l) => emit(PhoneAuthSmsCodeReceived()),
        (r) => emit(PhoneAuthSmsCodeReceived())));
  }

  Future<void> submitSmsCode(BuildContext context,
      {required String smsCode}) async {
    emit(PhoneAuthLoading());
    await verifyMobileUseCase.call(smsCode).then((value) => value.fold((l) {
          showSnackBar(context, "try again");
          emit(PhoneAuthInitial());
        }, (r) => emit(PhoneAuthSuccess())));
  }

  isSignIn(context) async {
    emit(PhoneAuthLoading());
    if (!await authIsSignInUseCase.authRepository
        .authIsSIgnIn()
        .then((value) => value.fold((l) => false, (r) {
              debugPrint(r.toString());
              return r;
            }))) {
      showSnackBar(context, "Auth. failed");
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesName.signIn , (route) => false);
    } else {
      debugPrint("home page");
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesName.home , (route) => false);
    }
  }
}
