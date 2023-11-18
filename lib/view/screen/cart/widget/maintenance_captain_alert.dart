import 'package:eamar_user_app/provider/cart_provider.dart';
import 'package:eamar_user_app/utill/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class MaintenanceCaptainAlertConfirmationDialog extends StatelessWidget {

final Function()? onYes;
  const MaintenanceCaptainAlertConfirmationDialog({super.key, this.onYes, });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text(
            
            getLang(context)=="ar"?" ${sharedPrefs.userName} من حرصنا عليك تم توفير خدمة الصيانة مجانا لك لنسهل عليك عملية البحث . الموقع أو الشركة غير مسؤولة عن أي عملية تعاقدية أو اتفاق بينك و بينك كابتن الصيانة" :"${sharedPrefs.userName} Out of our concern for you, we have provided you with a free maintenance service to facilitate the search process for you. The site or the company is not responsible for any contractual process or agreement between you and the maintenance captain"
            
            , style: robotoBold, textAlign: TextAlign.center),
        ),

        Divider(height: 0, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () {
            
                          
                         onYes!();

                          Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(

 getLang(context)=="ar"?
                "متابعة":"Continue"
                // getTranslated('YES', context)!
                
                
                
                , style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.RED, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(
                getLang(context)=="ar"?
                "إلغاء":"Cancel"
                
                // getTranslated('NO', context)!
              
              
              
              , style: titilliumBold.copyWith(color: ColorResources.WHITE)),
            ),
          )),

        ]),
      ]),
    );
  }
}
