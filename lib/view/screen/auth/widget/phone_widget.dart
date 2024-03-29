
import 'dart:developer';

import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/phone_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/countries.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/basewidget/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PhoneWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final String? label;
final Function(String?)? onchanged;
final String? countryCode;
final String? initalNumber;

  const PhoneWidget({super.key, this.enabled, this.controller,  this.onchanged, this.countryCode, this.initalNumber, this.label});
  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  String? _selectedCountryCode;
  List<String> _countryCodes = ['+966', '+972' , '+967'];



Widget _prefix(){
   var provider =Provider.of<PhoneNumberProvider>(context);
  return 
  // SizedBox();
  GestureDetector(
    onTap: (){

      showDialog(context: context, builder: (_)=>const 
      CountryFlags());
    },
    child: Container(
      child:  Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [ 
      SvgPicture.asset(
         provider.searchCountries.isNotEmpty?
  provider.searchCountries[provider.selectedCountryIndex].flag!
  
  : provider.countries[provider.selectedCountryIndex].flag!, 

  height: 20 ,width: 30,
)
    // Image.asset(
    //   provider.searchCountries[provider.selectedCountryIndex].flag!
      
    //   // 'assets/images/ploand_flag.png'
    //   )
      
      , 
    const SizedBox(width: 1,),
     Text(
       provider.searchCountries.isNotEmpty?
       provider.searchCountries[provider.selectedCountryIndex].countryCode!

       :  provider.countries[provider.selectedCountryIndex].countryCode!
      // '+62'
      , 
    
    style: const TextStyle(
    fontSize: 16, 
    fontWeight: FontWeight.w500
    ),
    ) , 
    
    const SizedBox(width: 5,)
    ,
    const Icon(Icons.keyboard_arrow_down , 
    
    color:  Color(0xFF717E95),
    )
    ],
    
      ),
    ),
  );
}


@override
void initState() {
  super.initState();




  if(widget.initalNumber!= null){
seperatePhoneAndDialCode();

  }else{
        _selectedCountryCode='+966';
      }
}

 seperatePhoneAndDialCode() {
    Map<String, String> foundedCountry = {};
    for (var country in Countries.allCountries) {
      String dialCode = country["dial_code"].toString();
      if (widget.initalNumber!.contains(dialCode)) {
        foundedCountry = country;
      }
    }

    if (foundedCountry.isNotEmpty) {
      var dialCode = widget.initalNumber!.substring(
        0,
        foundedCountry["dial_code"]!.length,
      );
      var newPhoneNumber = widget.initalNumber!.substring(
        foundedCountry["dial_code"]!.length,
      );
      log({dialCode, newPhoneNumber}.toString());

      _selectedCountryCode= dialCode;
      widget.controller!.text = newPhoneNumber;
    }else {
      _selectedCountryCode='+966';
    }
  }

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: new BoxDecoration(
          color:   ColorResources.getTextfieldFilledColor(context),
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        // height: 45.0,
        margin: const EdgeInsets.all(3.0),
        //width: 300.0,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: _selectedCountryCode,
              items: _countryCodes.map((String value) {
                return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountryCode = value;
                });
              },
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
Visibility(
  
  visible: 



widget.label!=null
 ,  

 child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [   
     Text(
          
          widget.label ?? '' ,
         
         style: Theme.of(context).textTheme.titleMedium,
         
         ),
         SizedBox(height: 5,),
  ],
 ),
),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            height: isTablet(context)?65:50,
            width: double.infinity,
            margin: new EdgeInsets.only(
              // top: 10.0, 
              // bottom: 10.0,
            
            //  right: 3.0
             ),
            color: Colors.white,
            child: new TextFormField(
              textDirection:   TextDirection.ltr,
        
              validator: (value) {
                if (value!.isEmpty) {
                  return 
                  getLang(context)=="ar"?
                  "هذا الحقل مطلوب":
                  
                  'This field is required';
                }
                return null;
              },
              onChanged:(str){

      var compltedPhone=      str.replaceFirst(new RegExp(r'^0+'), '');
                 widget.onchanged!(_selectedCountryCode!+compltedPhone);
              },
                maxLength: 10,
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              controller: widget.controller,
              decoration: new InputDecoration(
                                border: InputBorder.none,
        counterText: '',
               filled:true,
                      fillColor: 
                      // Color(0xFFf9fafc),
                      
                     ColorResources.getTextfieldFilledColor(context),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal:
                    12.0 ,  
                  vertical: 15
                  
                  ),
                 
        
                  
                  prefixIcon: _prefix(),
                  hintText: 
                  getLang(context)=="ar"?
                  "رقم الهاتف":
                  'Phone Number',
                  labelText: ''),
            ),
          ),
        ),
      ],
    );
  }
}
