import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';

ThemeData light = ThemeData(
  fontFamily: 'Cairo',
    primaryColor:Color(0xFF8B8000)
    
    //  Color(0xFFf8ab1d)
     ,


  cardColor:Colors.white,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  // scaffoldBackgroundColor: ColorResources.LIGHT_SKY_BLUE,
  hintColor: Color(0xFF9E9E9E),
  colorScheme: ColorScheme.light(
    onPrimary: Colors.black,
    primary:
    //  Color(0xFFf8ab1d)
    Color(0xFF8B8000)
    , secondary:
    // Color(0xFF8B8000)
     Color(0xFFf8ab1d)
    
    
    ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: 
  // Color(0xFFf8ab1d)
  Color(0xFF8B8000)
  
  )),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);