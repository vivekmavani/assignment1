import 'package:flutter/material.dart';
import 'package:sixtystrong/core/utils/colors.dart';

class SixtyStrongThemes{
  static ThemeData buildLightTheme()
  {
    ThemeData base=ThemeData.light();
    return base.copyWith(
      primaryColor:kColorWhite,
      brightness:Brightness.light,
      accentColor:kButtonColorGreen,
      unselectedWidgetColor:kButtonDisableColor,
      primaryColorDark:kButtonColorGreen,
      backgroundColor: kColorWhite,
      iconTheme: IconThemeData(color: kButtonColorGreen),
      //primaryColor:darkGreen,
      toggleableActiveColor: kColorAccent,
      primaryIconTheme: const IconThemeData.fallback().copyWith(
        color:kColorAccent,
      ),
      appBarTheme:AppBarTheme(
          color:kColorWhite,
          brightness:Brightness.light,
          iconTheme: IconThemeData(color: kButtonColorGreen),

          textTheme:TextTheme(
              headline6: TextStyle(
                color:kTitleColor,
                fontSize: 18,
              ))),

    );
  }

  static ThemeData buildDarkTheme()
  {
    final ThemeData base=ThemeData.dark();
    return base.copyWith(
        iconTheme: IconThemeData(color: kButtonColorGreen),
        accentColor:kColorAccent,
        brightness:Brightness.dark,
        unselectedWidgetColor:kButtonDisableColor,
        backgroundColor: kColorWhite,
        toggleableActiveColor: kColorAccent,
        appBarTheme:const AppBarTheme(
            brightness:Brightness.dark,
            iconTheme: IconThemeData(color: kButtonColorGreen),
            textTheme:TextTheme(
                headline6: TextStyle(

                    fontSize: 18,
                ))
        )
    );
  }
}
