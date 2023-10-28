import 'package:flutter/material.dart';
import 'package:eamar_user_app/utill/color_resources.dart';

ThemeData light = ThemeData(
  fontFamily: 'Cairo',
    primaryColor:Color(0xFFe69211)
    
    //  Color(0xFFf8ab1d)
     ,
floatingActionButtonTheme: FloatingActionButtonThemeData(
  backgroundColor: Color(0xFFe69211)
),
appBarTheme: AppBarTheme(

  iconTheme: IconThemeData(
    size: 35
  )
),
  cardColor:Colors.white,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  // scaffoldBackgroundColor: ColorResources.LIGHT_SKY_BLUE,
  hintColor: Color(0xFFe69211),
  colorScheme: ColorScheme.light(
    onPrimary: Colors.black,
    primary:
    //  Color(0xFFf8ab1d)
    Color(0xFFe69211)
    , secondary:
    // Color(0xFF8B8000)
     Color(0xFFf8ab1d)
    
    
    ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color(0xFF8B8000)
  
  )),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);