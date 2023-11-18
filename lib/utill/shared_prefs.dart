import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
static   SharedPreferences? sharedPreferences;


  static init()async{

    if (sharedPreferences ==null) {
      sharedPreferences =await SharedPreferences.getInstance();
    }
  }
String get userName => sharedPreferences!.getString('userName')??'';

set userName(String name){
  sharedPreferences!.setString('userName', name);
}






}
SharedPrefs sharedPrefs= SharedPrefs();