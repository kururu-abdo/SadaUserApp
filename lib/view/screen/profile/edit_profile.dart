import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamar_user_app/data/model/response/user_info_model.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/basewidget/animated_custom_dialog.dart';
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_textfield.dart';
import 'package:eamar_user_app/view/screen/auth/widget/phone_widget.dart';
import 'package:eamar_user_app/view/screen/more/widget/delete_account_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserInfoModel? userInfoModel;
  const EditProfile({super.key, this.userInfoModel});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
String?  phone ='';
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  File? file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void _choose(
    ImageSource source
  ) async {
    try {
      final pickedFile = await picker.pickImage(source:source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  
  Navigator.pop(context);
    } catch (e) {
      


       Navigator.pop(context);
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(content: 
          Text('Invalid Image')
          
          )

        );
    }
  
  }

  _updateUserAccount() async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _firstNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = phone!.trim();
    
    //  _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();

    if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.fName == _firstNameController.text
        && Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.lName == _lastNameController.text
        && Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.phone == _phoneController.text && file == null
        && _passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Change something to update'),
          backgroundColor: ColorResources.RED));
    }

    else if (_firstName.isEmpty || _lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.RED));
    }

    else if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.RED));
    }

    else if (phone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.RED));
    }

    else if((_password.isNotEmpty && _password.length < 6)
        || (_confirmPassword.isNotEmpty && _confirmPassword.length < 6)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should be at least 6 character'),
          backgroundColor: ColorResources.RED));
    }

    else if(_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
          backgroundColor: ColorResources.RED));
    }

    else {

      log('PHONE UPDATE'+ phone.toString());
      UserInfoModel updateUserInfoModel = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!;
      updateUserInfoModel.method = 'put';
      updateUserInfoModel.fName = _firstNameController.text ;
      updateUserInfoModel.lName = _lastNameController.text ;
      updateUserInfoModel.phone = phone!.trim() ;
      String pass = _passwordController.text ;

      await Provider.of<ProfileProvider>(context, listen: false).
      updateUserInfo(
        updateUserInfoModel, pass, file, Provider.of<AuthProvider>(context, listen: false).getUserToken(),
      ).then((response) {
        if(response.isSuccess) {
          Provider.of<ProfileProvider>(context, listen: false).
          getUserInfo(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully'),
              backgroundColor: Colors.green));
        //   _passwordController.clear();
        //   _confirmPasswordController.clear();
        //   setState(() {});
        Navigator.pop(context);
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message!),
              backgroundColor: Colors.red));
        }
      });
    }
  }


initData()async{




    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

 _firstNameController.text = widget.userInfoModel!.fName!;
            _lastNameController.text = widget.userInfoModel!.lName!;
            _emailController.text = widget.userInfoModel!.email!;
            _phoneController.text = widget.userInfoModel!.phone!;
             phone =widget.userInfoModel!.phone;

         setState(() {
           
         });
    });
}


@override
void initState() {
  super.initState();

  ///TODO:  edit Company Data
  initData();
}
  @override
  Widget build(BuildContext context) {
      
  log("NUMBER    "+  phone.toString());
    return 
     Scaffold(
      key: _scaffoldKey,
      body: 
      
      
      Padding(
        padding:  EdgeInsets.only(

          // top:20, 

          bottom:  MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            // _firstNameController.text = profile.userInfoModel!.fName!;
            // _lastNameController.text = profile.userInfoModel!.lName!;
            // _emailController.text = profile.userInfoModel!.email!;
            // // _phoneController.text = profile.userInfoModel!.phone!;
            //   phone =profile.userInfoModel!.phone;
              
            print('wallet amount===>${profile.userInfoModel!.walletBalance}');
              
            return Stack(clipBehavior: Clip.none,
              children: [
                Image.asset(Images.toolbar_background, fit: BoxFit.fill, height: 500,
                  color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,),
              
                Container(padding: EdgeInsets.only(top: 40, left: 15),
                  child: Row(children: [
                    CupertinoNavigationBarBackButton(
                      onPressed: () => Navigator.of(context).pop(),
                      color: Colors.white,),
                    SizedBox(width: 10),
              
                    Text(       
                     getLang(context)=="ar"?
                     "تعديل الملف الشخصي":"Edit profile"
                      ,
                        style: titilliumRegular.copyWith(fontSize: 20, color: Colors.white),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ]),
                ),
              
                Container(padding: EdgeInsets.only(top: 60),
                  child: Column(children: [
                    Column(
                      children: [
                        Container(margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle,),
                          child: Stack(clipBehavior: Clip.none,
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(50),
                                child: file == null ?
        
                                   CachedNetworkImage(
          width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover,
            cacheKey: profile.userInfoModel!.image,
               imageUrl:'${Provider.of<SplashProvider>(context,listen: false).baseUrls!.customerImageUrl}'
                '/${profile.userInfoModel!.image}',
              //  progressIndicatorBuilder: (context, url, downloadProgress) => 
        
              //          CircularProgressIndicator(value: downloadProgress.progress),
              
              
               errorWidget: (context, url, error) =>Image.asset(Images.placeholder,
               width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover),
        placeholder: (context ,child)=>Image.asset(
          Images.placeholder, 
        width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover
        ),
            )
                               
                               
                               
                               
                               
                               
                                // FadeInImage.assetNetwork(
                                //   placeholder: Images.placeholder, width: Dimensions.profileImageSize,
                                //   height: Dimensions.profileImageSize, fit: BoxFit.cover,
                                //   image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${profile.userInfoModel!.image}',
                                //   imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                                //       width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover),
                                // ) 
                                
                                
                                :
                                Image.file(file!, width: Dimensions.profileImageSize,
                                    height: Dimensions.profileImageSize, fit: BoxFit.fill),),
                              Positioned(bottom: 0, right: -10,
                                child: CircleAvatar(backgroundColor: ColorResources.LIGHT_SKY_BLUE,
                                  radius: 14,
                                  child: IconButton(onPressed:
                                  
                                  (){
                                  //  _choose();
              
                                   showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
             maxWidth: MediaQuery.of(context).size.width,              
          ),
        builder: (BuildContext cntx) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera
                  , size:  isTablet(context)? 35 : 24,
                  
                  ),
                  title: Text(
                    getLang(context)=="ar"?
                    "افتح الكاميرا":
                    
                    "Open camera",    style: 
                    TextStyle(fontSize: isTablet(context)? 30 : 18),),
                  onTap: () async {
              _choose(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image ,size:  isTablet(context)? 35 : 24,  ),
                  title:  Text(
                    getLang(context)=="ar"?
                    "افتح المعرض":
                    
                    "Open gallery",
                    style: 
                    TextStyle(fontSize: isTablet(context)? 30 : 18),
                    
                    ),
                  onTap: () async {
                              _choose(ImageSource.gallery);
                  
                  },
                ),
                Container(
                  height: isTablet(context)? 70:  50,
                  color: Colors.red,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        getLang(context)=="ar"?
                    "إلغاء":
                        "Cancel",
                        style: TextStyle(color: Colors.white,  
                        
                        
                       fontSize: isTablet(context)? 30 : 18
                        
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        });
                                   
                                   
                                  },
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.edit, color: ColorResources.WHITE, size: 18),),),
                              ),
                            ],
                          ),
                        ),
              
                        Text('${profile.userInfoModel!.fName} ${profile.userInfoModel!.lName}',
                          style: titilliumSemiBold.copyWith(color: ColorResources.WHITE, fontSize: 20.0),)
                      ],
                    ),
              
                    SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
              
              
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.getIconBg(context),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.MARGIN_SIZE_DEFAULT),
                            topRight: Radius.circular(Dimensions.MARGIN_SIZE_DEFAULT),)),
                      child: ListView(physics: BouncingScrollPhysics(),
                        children: [
                          Container(margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Row(children: [
                              Expanded(child: Column(
                                children: [Row(children: [
                                  Icon(Icons.person, color: ColorResources.getLightSkyBlue(context), size: 20),
                                  SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                  Text(getTranslated('FIRST_NAME', context)!, style: titilliumRegular .copyWith(
                                    fontSize:  isTablet(context)? 20:null
                                  ))
                                ],
                                ),
                                  // SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
              
                                  CustomTextField(textInputType: TextInputType.name,
                                    focusNode: _fNameFocus,
                                    nextNode: _lNameFocus,
                                    hintText: '',
                                    controller: _firstNameController,
                                  ),
                                ],
                              )),
                              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
              
                              Expanded(child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.person, color: ColorResources.getLightSkyBlue(context), size: 20),
                                    SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                    Text(getTranslated('LAST_NAME', context)!, style: titilliumRegular .copyWith(
                                    fontSize:  isTablet(context)? 20:null
                                  ))
                                  ],),
                                  // SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
              
                                  CustomTextField(
                                    textInputType: TextInputType.name,
                                    focusNode: _lNameFocus,
                                    nextNode: _emailFocus,
                                    hintText: '',
                                    controller: _lastNameController,
                                  ),
                                ],
                              )),
                            ],
                            ),
                          ),
              
              
              
                          Container(margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_DEFAULT,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Column(children: [
                              Row(children: [Icon(Icons.alternate_email,
                                  color: ColorResources.getLightSkyBlue(context), size: 20),
                                  SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,),
                                  Text(getTranslated('EMAIL', context)!, 
                                  
                                  style: titilliumRegular .copyWith(
                                    fontSize:  isTablet(context)? 20:null
                                  )
                                  
                                  
                                  )
                                ],
                              ),
                              // SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
              
                              CustomTextField(textInputType: TextInputType.emailAddress,
                                focusNode: _emailFocus,
                                nextNode: _phoneFocus,
                                hintText: 
                                 '',
                                controller: _emailController,
                              ),
                            ],
                            ),
                          ),
              
              
                          Container(margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_DEFAULT,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Column(children: [
                              Row(children: [
                                Icon(Icons.dialpad, color: ColorResources.getLightSkyBlue(context), size: 20),
                                SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                Text(getTranslated('PHONE_NO', context)!, style: titilliumRegular .copyWith(
                                    fontSize:  isTablet(context)? 20:null
                                  ))
                              ],),
                              // SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
              
                              PhoneWidget(
               controller: _phoneController,
               initalNumber: 
              //  _phoneController.text
               "+9660978768678670"
               
               ,
              onchanged: (str){
        log(
          "PHONE  JNUMBER"+
          
          str.toString());
               
        phone=str!.trim();
        //  setState(() {
          
        // });
              },
                                
                              )
              
                              // CustomTextField(textInputType: TextInputType.number,
                              //   focusNode: _phoneFocus,
                              //   hintText: profile.userInfoModel!.phone ?? "",
                              //   nextNode: _addressFocus,
                              //   controller: _phoneController,
                              //   isPhoneNumber: true,
                              // ),
                              
                              ],
                            ),
                          ),
              
        


///SUB CODE
        // Container(
        //   height: 60,
        // margin: EdgeInsets.only(   
          
        //    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
        //                       top: Dimensions.MARGIN_SIZE_DEFAULT,
        //                       left: Dimensions.MARGIN_SIZE_DEFAULT,
        //                       right: Dimensions.MARGIN_SIZE_DEFAULT),
          
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
            
        //     children: [ 
        //      Row(  crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [ 


        //             Icon(Icons.dialpad, color: ColorResources.getLightSkyBlue(context), size: 40),
        //    SizedBox(width: 5,),

           
           
        //       Column(crossAxisAlignment: CrossAxisAlignment.start,
        // children: [ 
          
        //   SizedBox(width: 5,),
        //       Text(
        //         getLang(context)=="ar"?
        //         "تحديث رقم الهاتف":
                
        //         'Update Phone Number',
        //           style: titilliumRegular .copyWith(
        //                             fontSize:  isTablet(context)? 20:null
        //                           )
                
        //         ) , 
        //   SizedBox(height: 5,),
        //   Directionality(
        //      textDirection: TextDirection.ltr,
        //     child: Text(phone!,  
            
        //     style: TextStyle(
        //       fontSize: 12,  color: Colors.black54
        //     ),
        //     ))
        // ],
        //       )
        //       ],
        //      )
        //   , 
          
        //   IconButton(onPressed: (){
          
        // }, icon: Icon(Icons.arrow_forward_ios,  
        
        
        // color: ColorResources.HINT_TEXT_COLOR,
        // )),
             
        //     ],
        //   ),
        // ),
        
//         Container(   height: 60,
//         margin: EdgeInsets.only(
//           bottom: Dimensions.MARGIN_SIZE_DEFAULT,
//                               // top: Dimensions.MARGIN_SIZE_DEFAULT,
//                               left: Dimensions.MARGIN_SIZE_DEFAULT,
//                               right: Dimensions.MARGIN_SIZE_DEFAULT),
          
//           child: Row( crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
//             children: [ 
//   Row(
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [ 

//       Icon(Icons.lock_open, color: ColorResources.getPrimary(context), 
//       size: 40),
// SizedBox(width: 5,),
//               Column(crossAxisAlignment: CrossAxisAlignment.start,
//         children: [ 
          
//           SizedBox(width: 5,),
//               Text(
//                 getLang(context)=="ar"?
//                 "تحديث كلمة المرور":
                
//                 'Update Password',
//                   style: titilliumRegular .copyWith(
//                                     fontSize:  isTablet(context)? 20:null
//                                   )
//                 ) , 
//           SizedBox(height: 8,),
//           Directionality(
//              textDirection: TextDirection.ltr,
//             child: Text("************" ,
//              style: TextStyle(
//               fontSize: 12,  color: Colors.black54
//             ),
            
            
//             ))
//         ],
//               )
//           , 
//     ],
//   ),
          
//           IconButton(onPressed: (){
//           showModalBottomSheet(context: context,
//                 isScrollControlled: true, 
                
//                 backgroundColor: Colors.transparent,
//   constraints: BoxConstraints(
//      maxWidth: MediaQuery.of(context).size.width,              
//   ),
//                 builder: (c) => ChangePasswordBottomSheet()
//                 );
//         }, icon: Icon(Icons.arrow_forward_ios, 
        
//         color:
//         ColorResources.HINT_TEXT_COLOR
//         )),
             
//             ],
//           ),
//         ),
        
          
          
          
              
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
                                focusNode: _passwordFocus,
                                nextNode: _confirmPasswordFocus,
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
                                focusNode: _confirmPasswordFocus,
                                textInputAction: TextInputAction.done,
                              ),
                            ],),
                          ),
                    
                    
                    
                    
                    
                    SizedBox(height: MediaQuery.of(context).size.height*.10,),
                    
                              Center(
        child: 
        Container(margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_LARGE,
                        vertical: Dimensions.MARGIN_SIZE_SMALL),
                      child: !Provider.of<ProfileProvider>(context).isLoading ?
                      CustomButton(onTap: _updateUserAccount, buttonText: 
                      
                      
                     getLang(context)=="ar"?
                     "حفظ":"Save"
                      
                      
                      
                      ) :
                      Center(child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                    ),  
             
             
              )
                    
                    
                        ],
                      ),
                    ),
                    ),
              
              
        //                                           SizedBox(height:
                                                  
                                                  
        //                                            Dimensions.MARGIN_SIZE_LARGE),
              
        //                       Center(
        // child: InkWell(
        //   onTap: () =>                    showAnimatedDialog(context, 
        //   DeleteAccountConfirmationDialog()
        //   , isFlip: true),
              
          
        //   // async{
        //   //                 Provider.of<ProfileProvider>(context, listen: false).deleteAccount(context);
              
        //   // },
        //   child: Container(
        // margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_LARGE,
        //                 vertical: Dimensions.MARGIN_SIZE_SMALL),
        //  width:MediaQuery.of(context).size.width ,height:
         
        //  isTablet(context)? 55:
        //  45 ,
        //  padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //  color: Colors.red ,
        //  borderRadius: BorderRadius.circular(10)
        // ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        
        
        // Icon(Icons.dangerous , color: Colors.white,size:  isTablet(context)? 35:24,),
        // SizedBox(width: 15,) ,
        //     Text(getTranslated('DELETE_ACCOUNT', context)! , style: TextStyle(
        //       color: Colors.white , 
        //       fontSize:  isTablet(context)?  24: 18
        //     ),)
        //   ],
        // ),
        //   ),
        // )
        //       )
                    
        //                   ,
                        
        //             Container(margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_LARGE,
        //                 vertical: Dimensions.MARGIN_SIZE_SMALL),
        //               child: !Provider.of<ProfileProvider>(context).isLoading ?
        //               CustomButton(onTap: _updateUserAccount, buttonText: getTranslated('UPDATE_ACCOUNT', context)) :
        //               Center(child: CircularProgressIndicator(
        //                   valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
        //             ),
                 
                 
                 
                  ],
                  ),
                ),
            
            
              ],
            );
            },
        ),
      ),
  
  
  
    );
 
  }
}