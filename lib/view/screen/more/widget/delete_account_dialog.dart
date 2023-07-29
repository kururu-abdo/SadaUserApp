import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';
import 'package:eamar_user_app/view/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../provider/profile_provider.dart';

class DeleteAccountConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text(getTranslated('DELETE_CONFIRMATION', context)!, style: robotoBold, textAlign: TextAlign.center),
        ),

        Divider(height: 0, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () {




                                  // Provider.of<AuthProvider>(context ,listen: false)
                                  // .removeAccount('temporaryToken')
                                  // ;
     Provider.of<ProfileProvider>(context, listen: false).deleteAccount(context);



              Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
                Navigator.pop(context);
                Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
                Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
                Provider.of<AuthProvider>(context,listen: false).clearSharedData();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
              });
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('YES', context)!, style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.RED, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('NO', context)!, style: titilliumBold.copyWith(color: ColorResources.WHITE)),
            ),
          )),

        ]),
      ]),
    );
  }
}