import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final bool? isFilled;
  AuthButton({this.onTap,this.isFilled=true, required this.buttonText, this.isBuy= false, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(

      onTap: isBuy?
      
      null: (){

        onTap!();
      }
      ,
      child: Container(
     height: 45,
     width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
           color: 
           
            isFilled!?
            ColorResources.getBtnColor(context):  

            Colors.transparent
           ,
            border:
            
            !isFilled!?
             Border.all(
              width: 1, 
            ):null,
              borderRadius: 
              BorderRadius.circular(5)),
          child: 
          isBuy? CircularProgressIndicator.adaptive():
          
          
          Text(buttonText!,
              style: titilliumSemiBold.copyWith(
                fontSize: 16,
                // color: Theme.of(context).highlightColor,
              )
    
          )
    
    
      ),
    );





    !isFilled!?
  TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
         
          border: Border.all(
            width: 1, 
          ),
            borderRadius: BorderRadius.circular(isBorder? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL)),
        child: Text(buttonText!,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              // color: Theme.of(context).highlightColor,
            )),
      ),
    ):
    TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
           ColorResources.getChatIcon(context),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: (Provider.of<ThemeProvider>(context).darkTheme || onTap == null) ? null : isBuy?
            LinearGradient(colors: [
              Color(0xffFE961C),
              Color(0xffFE961C),
              Color(0xffFE961C),
            ]):
            LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ]),
            borderRadius: 
            BorderRadius.circular(isBorder? 
            Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL)),
        child: Text(buttonText!,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).highlightColor,
            )),
      ),
    );
  
  
  }
}
