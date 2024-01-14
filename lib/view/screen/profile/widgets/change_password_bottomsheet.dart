import 'package:eamar_user_app/data/model/response/user_info_model.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  State<ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  
    final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return     Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height*.50,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child:
Column(children: [ 

      Container(margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_DEFAULT,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Column(children: [
                              Row(children: [
                                Icon(Icons.lock_open, color: ColorResources.getPrimary(context), size: 20),
                                SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                Text(getTranslated('PASSWORD', context)!, style: titilliumRegular
                                 .copyWith(
                                    fontSize:  isTablet(context)? 20:null
                                  )
                                
                                )
                              ],),
                              SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
              
                              CustomPasswordTextField(controller: _passwordController,
                                // focusNode: _passwordFocus,
                                // nextNode: _confirmPasswordFocus,
                                textInputAction: TextInputAction.next,
                              ),
                            ],),
                          ),
              
              
                          Container(margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_DEFAULT,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Column(children: [
                              Row(
                                children: [
                                  Icon(Icons.lock_open, color: ColorResources.getPrimary(context), size: 20),
                                  SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                  Text(getTranslated('RE_ENTER_PASSWORD', context)!, style: titilliumRegular
                                  .copyWith(
                                    fontSize:  isTablet(context)? 20:null
                                  )
                                  
                                  )
                                ],),
                              SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
              
              
                              CustomPasswordTextField(controller: _confirmPasswordController,
                                // focusNode: _confirmPasswordFocus,
                                textInputAction: TextInputAction.done,
                              ),
                            ],),
                          ),
                    
                   Spacer() , 

CustomButton(buttonText: 
getLang(context)=="ar"?"تحدث كلمو المرور":
'Update password' , 
onTap: (){
  
},
), 
                   SizedBox(height: 20,) 

])

    );
  }
}