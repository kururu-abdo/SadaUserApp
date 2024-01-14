import 'dart:developer';

import 'package:eamar_user_app/main.dart';
import 'package:eamar_user_app/view/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class ApiChecker {

  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    log('HERER');
    log(apiResponse.response.toString());
    if(apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthorized.') {
      Provider.of<ProfileProvider>(MyApp.navigatorKey.currentContext!,listen: false).clearHomeAddress();
      Provider.of<ProfileProvider>(MyApp.navigatorKey.currentContext!,listen: false).clearOfficeAddress();
      Provider.of<AuthProvider>(MyApp.navigatorKey.currentContext!,listen: false).clearSharedData();
      Navigator.of(MyApp.navigatorKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>
       AuthScreen()), (route) => false);
    }else {
      String? _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
     ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(_errorMessage!, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }


  static void checkApi2(BuildContext context, ApiResponse apiResponse) {
    log('HERER');
    log(apiResponse.response.toString());
    if(apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthorized.') {
      Provider.of<ProfileProvider>(MyApp.navigatorKey.currentContext!,listen: false).clearHomeAddress();
      Provider.of<ProfileProvider>(MyApp.navigatorKey.currentContext!,listen: false).clearOfficeAddress();
      Provider.of<AuthProvider>(MyApp.navigatorKey.currentContext!,listen: false).clearSharedData();
      // Navigator.of(MyApp.navigatorKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>
      //  AuthScreen()), (route) => false);
    }else {
      String? _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
     ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(_errorMessage!, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }



}