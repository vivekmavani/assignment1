import 'package:flutter/material.dart';

import '../../../../core/utils/image_path.dart';


class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(ImagePath.logo,height: double.infinity,width: double.infinity, // for splash center
      fit: BoxFit.cover,),
    );
  }
}
