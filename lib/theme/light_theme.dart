import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Cairo',
  //  primaryColor: Color(0xFFf1ed70),
primaryColor:Color(0xFFa3a25f),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: Color(0xFF9E9E9E),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);