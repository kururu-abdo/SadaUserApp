import 'package:eamar_user_app/utill/sizes.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';

class GuestDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [

        Positioned(
          left: 0, right: 0, top: -50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(Images.login, height: 80, width: 80),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(getTranslated('THIS_SECTION_IS_LOCK', context)!, style: robotoBold.copyWith(fontSize: 
              
              
              isTablet(context)? 20:
              Dimensions.FONT_SIZE_LARGE)),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Text(getTranslated('GOTO_LOGIN_SCREEN_ANDTRYAGAIN', context)!, textAlign: TextAlign.center, style: titilliumRegular),
              SizedBox(height:
               isTablet(context)? 25:
              
               Dimensions.PADDING_SIZE_LARGE),

              Divider(height: 0, color: Theme.of(context).hintColor),
              Row(children: [

                Expanded(child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
                    child: Text(getTranslated('CANCEL', context)!, style: titilliumBold.copyWith(

                      fontSize:  isTablet(context)? 18: null,
                      color: Theme.of(context).primaryColor)),
                  ),
                )),

                Expanded(child: InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => AuthScreen()), (route) => false),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
                    child: Text(getTranslated('LOGIN', context)!, style: titilliumBold.copyWith(
                         fontSize:  isTablet(context)? 18: null,
                      
                      color: Colors.white)),
                  ),
                )),

              ]),
            ],
          ),
        ),

      ]),
    );
  }
}
