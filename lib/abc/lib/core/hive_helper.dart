import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  open() async {
      if(!kIsWeb){
        Directory appDocDir = await getApplicationDocumentsDirectory();
        Hive
            .init(appDocDir.path);
      }

  }

  bool isBoxOpen() {
    return Hive.isBoxOpen(Boxes.myBox);
  }

  Future<Box> myBox() async {
    return await Hive.openBox(Boxes.myBox);
  }

  close() {
    Hive.close();
  }
}

class Boxes {
  static const String myBox = 'myBox';
}
