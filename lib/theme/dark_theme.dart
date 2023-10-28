import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: Color(0xFFe69211),
 cardColor:Colors.black,
//  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
  highlightColor: Color(0xFF252525),
  hintColor: Color(0xFFc7c7c7),

appBarTheme: AppBarTheme(

  iconTheme: IconThemeData(
    size: 35
  )
),


    colorScheme: ColorScheme.dark(primary: Color(0xFFe69211), secondary: Color(0xFFe69211)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color(0xFFe69211))),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
