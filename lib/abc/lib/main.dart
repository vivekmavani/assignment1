import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sixtystrong/base/theme/sixty_strong_theme.dart';
import 'package:sixtystrong/core/navigation_observer.dart';
import 'package:sixtystrong/core/utils/strings.dart';
import 'core/utils/colors.dart';
import 'features/injection_container.dart';
import 'routes.dart' as sixtyRoutes;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
      runZonedGuarded(() {
        runApp(MyApp());
      }, (error, stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      });
    });
  });
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      navigatorObservers: [
        NavigationObserver()
      ],
      theme: SixtyStrongThemes.buildLightTheme(),
      darkTheme: SixtyStrongThemes.buildLightTheme(),
      onGenerateRoute: sixtyRoutes.Router.generateRoutes,
      color: kColorAccent,
      builder: (context, child) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child);
      },
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
