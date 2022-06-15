import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../cubit/auth_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignInButton(
            Buttons.Google,
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).googleAuth();
            },
          ),
          Visibility(
            visible: Platform.isIOS,
            child: SignInButton(
              Buttons.Apple,
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).appleAuth();
              },
            ),
          ),
          TextButton(
              onPressed: () => BlocProvider.of<AuthCubit>(context).otpPage(),
              child: const Text("Continue with OTP"))
        ],
      ),
    );
  }
}
