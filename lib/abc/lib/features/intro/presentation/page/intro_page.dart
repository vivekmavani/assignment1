import 'package:flutter/material.dart';
import '../../../../route_name.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              child: const Text(
                "Next",
              ),
              onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.signIn, (route) => false))),
    );
  }
}
