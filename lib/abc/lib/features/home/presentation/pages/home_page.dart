import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),actions: [
        InkWell(onTap: () {
          BlocProvider.of<AuthCubit>(context).signOut();
        }   ,child: const Icon(Icons.logout)),
      ],),
    );
  }
}
