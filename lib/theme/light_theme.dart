import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Cairo',
    primaryColor: Color(0xFFa3a25f),

  cardColor:Colors.white,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: Color(0xFF9E9E9E),
  colorScheme: ColorScheme.light(
    onPrimary: Colors.black,
    primary: Color(0xFFa3a25f), secondary: Color(0xFFa3a25f)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Color(0xFFa3a25f))),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);