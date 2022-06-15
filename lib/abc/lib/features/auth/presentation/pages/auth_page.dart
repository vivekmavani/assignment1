import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixtystrong/features/auth/presentation/pages/phone_auth_page.dart';
import 'package:sixtystrong/features/auth/presentation/pages/sign_in_page.dart';

import '../../../../core/funcation/snack_bar.dart';
import '../../../../route_name.dart';
import '../cubit/auth_cubit.dart';



class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      BlocConsumer  < AuthCubit, AuthState > (
        listener: (context, state) {
          if (state is AuthError) {
            showSnackBar(context,state.message.toString());
          }else if(state is AuthLoaded){
            Navigator.of(context)
                     .pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
          }
        },
        builder: (context, state) {
          if(state is PhoneAuth){
            return const PhoneAuthPage();
          }
          return const SignInPage();
          // return widget here based on AuthBloc's state
        },
      ),
      /*BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthOrNot) {
            if (state.isAuth == true) {
            } else {
              return const SignInPage();
            }
          } else if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhoneAuth) {
            return const PhoneAuthPage();
          }
          return const Text('HI..');
        },
      ),*/
    );
  }
}
