import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {

  const SplashPage( {Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).isFirstUser(context,mounted);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  SafeArea(child: Text('Splash Screen')));
  }
}
