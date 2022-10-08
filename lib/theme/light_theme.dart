import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Cairo',
    primaryColor: Color(0xFFf8ab1d),

  cardColor:Colors.white,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: Color(0xFF9E9E9E),
  colorScheme: ColorScheme.light(
    onPrimary: Colors.black,
    primary: Color(0xFFf8ab1d), secondary: Color(0xFFf8ab1d)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Color(0xFFf8ab1d))),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);