import 'package:flutter/material.dart';

import '../view/screen/auth/widget/enter_phone_or_email_page.dart';

class PhoneEmailController

extends ChangeNotifier
 {
  

  EmailOrPhone? _emailOrPhone;
    EmailOrPhone?  get emailOrPhone => _emailOrPhone ;


setMethodd(EmailOrPhone phone){
  _emailOrPhone=phone;
  notifyListeners();
}



}