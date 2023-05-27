import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pp;
class AppPathProvider {
  AppPathProvider._();

  static String? _path;

  static String? get path {
    if (_path != null) {
      return _path;
    } else {
      throw Exception('path not initialized');
    }
  }

static  Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory

    final Directory _appDocDir = await pp.getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}/$folderName');

    final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }


  static Future<void> initPath() async {
    
    final dir = await pp.getApplicationDocumentsDirectory();
    _path = dir.path;
  }

}