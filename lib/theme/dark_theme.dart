import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: Color(0xFFfaf274),
 cardColor:Colors.black,
  brightness: Brightness.dark,
  highlightColor: Color(0xFF252525),
  hintColor: Color(0xFFc7c7c7),
    colorScheme: ColorScheme.dark(primary: Color(0xFFfaf274), secondary: Color(0xFFfaf274)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color(0xFFfaf274))),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
