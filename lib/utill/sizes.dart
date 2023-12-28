

import 'package:flutter/material.dart';

 bool isTablet(BuildContext context){

  return MediaQuery.of(context).size.width > 650;
}