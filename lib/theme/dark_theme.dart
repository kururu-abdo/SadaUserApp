import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: Color(0xFFe1eb99),
 cardColor:Colors.black,
  brightness: Brightness.dark,
  highlightColor: Color(0xFF252525),
  hintColor: Color(0xFFc7c7c7),
    colorScheme: ColorScheme.dark(primary: Color(0xFFe1eb99), secondary: Color(0xFFe1eb99)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Color(0xFFe1eb99))),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
