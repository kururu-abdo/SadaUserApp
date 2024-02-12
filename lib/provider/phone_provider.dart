import 'dart:developer';

import 'package:eamar_user_app/utill/country_codes.dart';
import 'package:flutter/material.dart';

class PhoneNumberProvider extends ChangeNotifier {
  PhoneNumberProvider(){
    searchCountries=countries;
  }

  int selectedCountryIndex=0;
  int? _selectedindex;
  String? phoneNumber;
CountryCode? countryCode;
 List<Country>  searchCountries =[];
 


  List<Country> countries = [
    Country( 
      name: 'Saudi Arabia' , 
      countryCode: '+966'  , 
      flag: 'assets/flags/sa.svg'  
    ), 
Country( 
      name: 'Sudan' , 
      countryCode: '+249'  , 
      flag: 'assets/flags/sd.svg'  
    ), 
Country( 
      name: 'South Sudan' , 
      countryCode: '+211'  , 
      flag: 'assets/flags/ss.svg'  
    ), 
    Country( 
      name: 'United States' , 
      countryCode: '+44'  , 
      flag: 'assets/flags/us.svg'  
    ), 
  ];

 seperatePhoneAndDialCode(String initalNumber) {
   Country? foundedCountry ;
    for (var country in countries) {
      String dialCode = country.countryCode.toString();
      if (initalNumber.contains(dialCode)) {
        foundedCountry = country;
      }
    }

    if (foundedCountry != null) {
      var dialCode = initalNumber.substring(
        0,
        foundedCountry.countryCode!.length,
      );
      var newPhoneNumber = initalNumber.substring(
        foundedCountry.countryCode!.length,
      );
      log({dialCode, newPhoneNumber}.toString());

      // _selectedCountryCode= dialCode;
      // controller!.text = newPhoneNumber;
    }else {
      // _selectedCountryCode='+966';
    }
  }
ini(){
  searchCountries=countries;
notifyListeners();
}
setSelecedIndex(int index){
  // _selectedindex=index;
  selectedCountryIndex=index;
  notifyListeners();
}
search(String s){
if (s.isNotEmpty) {
  searchCountries =countries.where((element) => element.name!
  
  .toLowerCase()
  .contains(s)).toList();
}else {
  searchCountries =countries;
}
notifyListeners();
}

}