
import 'dart:developer';

import 'package:eamar_user_app/data/model/body/login_model.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/cart_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/phone_utils.dart';
import 'package:eamar_user_app/view/basewidget/button/auth_button.dart';
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_textfield.dart';
import 'package:eamar_user_app/view/screen/auth/forget_password_screen.dart';
import 'package:eamar_user_app/view/screen/auth/signup_screen.dart';
import 'package:eamar_user_app/view/screen/auth/widget/enter_phone_or_email_page.dart';
import 'package:eamar_user_app/view/screen/auth/widget/mobile_verify_screen.dart';
import 'package:eamar_user_app/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:validate_ksa_number/validate_ksa_number.dart';

import 'otp_verification_screen.dart';

class AudeienceLogin extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<AudeienceLogin> {
  TextEditingController? _emailController;
    late TextEditingController _phoneController;

  TextEditingController? _passwordController;
    TextEditingController? _idController;

  GlobalKey<FormState>? _formKeyLogin;



  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _idController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController!.text = 
    Provider.of<AuthProvider>(context, listen: false).getUserEmail() ?? "";


    _passwordController!.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? "";
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _phoneController.dispose();
    _idController!.dispose();
    super.dispose();
  }

  FocusNode _emailNode = FocusNode();
   FocusNode _phoneNode = FocusNode();
    FocusNode _idFocusNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();
     var ksaValidate =KsaNumber();
 String _email =
//  _countryDialCode.trim()+
                    
                    // PhoneNumberUtils.getPhoneNumberFromInputs( 
                      _emailController!.text.trim()
                      
                      // )
                    ;
      String _password = _passwordController!.text.trim();



      
      
      
       if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } 
      
          
      
      
      else {

        if (Provider.of<AuthProvider>(context, listen: false).isRemember!) {
          Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_emailController!.text.trim(), _password);
        } else {
          Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
        }
        loginBody.email = _email;
loginBody.user_id =  _idController!.text.trim();
      print(loginBody.email);


        loginBody.password = _password;
     
        await Provider.of<AuthProvider>(context, listen: false).login(loginBody, route);
      }
    }
  }

  route(bool isRoute, String token, String temporaryToken, String errorMessage) async {
    if (isRoute) {
      if(token.isEmpty){
        if(Provider.of<SplashProvider>(context,listen: false).configModel!.emailVerification!){
          Provider.of<AuthProvider>(context, listen: false).checkEmail(_emailController!.text.toString(),
              temporaryToken).then((value) async {
            if (value.isSuccess) {
              // Provider.of<AuthProvider>(context, listen: false).setUserType('user');
              Provider.of<AuthProvider>(context, listen: false).updateEmail(_emailController!.text.toString());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => VerificationScreen(
                  temporaryToken,'',_emailController!.text.toString())), (route) => false);

            }
          });
        }else if(Provider.of<SplashProvider>(context,listen: false).configModel!.phoneVerification!){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MobileVerificationScreen(
              temporaryToken)), (route) => false);
        }
      }
      else{
                      Provider.of<AuthProvider>(context, listen: false).setUserType('user');

        await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }
  // String _countryDialCode = "+966";
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;

    return Padding(
      padding:  EdgeInsets.only(left: 
      Dimensions.MARGIN_SIZE_LARGE ,  
      right:  Dimensions.MARGIN_SIZE_LARGE , 

      // bottom: MediaQuery.of(context).viewInsets.bottom
      
      ),
      child: Form(
        key: _formKeyLogin,
        child: Container(
            padding:
           EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL ,
           
          //  bottom: MediaQuery.of(context).viewInsets.bottom
           ),


          child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
        
            children: [
        

             SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT
             ,),

             
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(
  MaterialPageRoute(builder: (_)=> EnterPhoneOrEmail(
  onSelect: (value){
_emailController!.text= value.emailOrPhone!;
  },
  )  ));
          },
          child: Container(
        
        
            decoration: BoxDecoration(
          //     boxShadow: [
          //   BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
          // ],
            ),
                                     margin:
                    EdgeInsets.only(
                      
                      bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                         
                         
                          child:
        
                          
                             
                             CustomTextField(
                                          hintText:
                                          
                                          getLang(context)=="ar"?"ادخل البريد الالكتروني او رقم الهاتف":"Enter Email or phone number" ,

                                          //  getTranslated('ENTER_MOBILE_NUMBER', context)
                                           
                                          focusNode: _emailNode,
                                          nextNode: _passNode,
                                          controller: _emailController,
                                          enabled:  false,
                                          isPhoneNumber: false,
                                          textInputAction: TextInputAction.next,
                                          textInputType: TextInputType.phone,
                                        ), 
                             
                             
        
        
        
                        ),
        ),
                    
                    
                    
                      SizedBox(
                        height: 10,
                      ) ,



              Container(
                  margin:
                  EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                  child: CustomPasswordTextField(
                    hintTxt: getTranslated('ENTER_YOUR_PASSWORD', context),
                    textInputAction: TextInputAction.done,
                    focusNode: _passNode,
                    controller: _passwordController,
                  )),
        
        
        
              // Container(
              //   margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
              //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [Row(children: [
              //       Consumer<AuthProvider>(
              //         builder: (context, authProvider, child) => Checkbox(
              //           checkColor: ColorResources.WHITE,
              //           activeColor: Theme.of(context).primaryColor,
              //           value: authProvider.isRemember,
              //           onChanged: authProvider.updateRemember,),),
        
        
              //       Text(getTranslated('REMEMBER', context)!,
              //        style: titilliumRegular),
              //     ],),
        
              //       InkWell(
              //         onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPasswordScreen())),
              //         child: Text(getTranslated('FORGET_PASSWORD', context)!,
              //             style: titilliumRegular.copyWith(
              //             color: ColorResources.getLightSkyBlue(context))),
              //       ),
              //     ],
              //   ),
              // ),
        
        
        
              Container(



                // margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
                
                   margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                
                child: Provider.of<AuthProvider>(context).isLoading ?
                Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor,),),) :
                AuthButton(onTap: loginUser,
                 buttonText: getTranslated('SIGN_IN', context)),),
            
            
            
//               SizedBox(height: 8),
        
//                Container(
//                     margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
//                  child: Align(
               
//                    alignment: getLang(context)=="ar"?
//                    Alignment.centerLeft: 
//                      Alignment.centerRight
//                    ,
//                    child:    getLang(context)=="ar"?
                   
                   
//                   RichText(
//                   text:  TextSpan(
//                       text: 'ليس لديك حساب؟' ,
                      
//                       style:  titilliumRegular.copyWith(
//                  color:      Provider.of<ThemeProvider>(context).darkTheme? 
                        
                        
                        
//                       Colors.white :Colors.black,


//                           fontSize: 16 ,fontWeight: FontWeight.w500
//                       ),
//                       children: [
//                         TextSpan(
//                           text: 'إنشاء حساب' ,
//                           recognizer:   TapGestureRecognizer()..onTap = () {
                        

//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context)=>   
//                            SignupScreen()
//                         ));
//                       },
//                           style: TextStyle(
//                             fontSize: 18 , fontWeight: FontWeight.w500 ,
//                             color: Theme.of(context).primaryColor
//                           )
//                         )
//                       ]
//                     )
//                   ):
               
//               RichText(
//                 text:    TextSpan(
//                       text: 'You don\'t have an accoount? ' ,
//                       style: titilliumRegular.copyWith(
//                         fontSize: 16 ,
//                         fontWeight: FontWeight.w500 ,


                     

//                         color: 
                        
//                           Provider.of<ThemeProvider>(context).darkTheme? 
                        
                        
                        
//                       Colors.white :Colors.black
//                       ),
//                       children: [
//                         TextSpan(
//                           text: 'create account' ,
// recognizer:   TapGestureRecognizer(

  
// )..onTap = () {
                        

//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context)=>   
//                            SignupScreen()
//                         ));
//                       },
                          
//                           style: TextStyle(
//                             fontSize: 18 , fontWeight: FontWeight.w500 ,
//                             color: Theme.of(context).primaryColor
//                           ),
                          
//                         )
//                       ]
//                     )
//                   )
               
                   
//                      ,
//                  ),
//                ),
        
              // SocialLoginWidget(),
              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        
        // SizedBox(height: 20,),
        //       Center(child: Text(getTranslated('OR', context)!,
        //           style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT))),
        
        
        
              // GestureDetector(
              //   onTap: () {
              //     if (!Provider.of<AuthProvider>(context, listen: false).isLoading) {
              //       Provider.of<CartProvider>(context, listen: false).getCartData();
              //             Provider.of<AuthProvider>(context, listen: false).setUserType(
              //               'visitor'
              //             );
              //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashBoardScreen()),
              //               (route) => false);
              //     }
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_AUTH, right: Dimensions.MARGIN_SIZE_AUTH,
              //         top: Dimensions.MARGIN_SIZE_AUTH_SMALL),
              //     width: double.infinity, height: 40, alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: Colors.transparent, borderRadius: BorderRadius.circular(6),),
              //     child: Text(getTranslated('CONTINUE_AS_GUEST', context)!,
              //         style: titleHeader.copyWith(color: ColorResources.getPrimary(context))),
              //   ),
              // ),
          
          
          SizedBox(height: 10,),
            Row(
              children: [
Expanded(child: 
Container(height: 1 ,color:  Color(0xFFeeeeee), )
) ,Text('Or') ,  


Expanded(child: 
Container(height: 1 ,color:  Color(0xFFeeeeee), )
) ,
              ],
            ),
               SizedBox(height: 10,),

              Container(



                // margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
                
                   margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                
                child:
                //  Provider.of<AuthProvider>(context).isLoading ?
                // Center(
                //   child:
                //    CircularProgressIndicator(
                //     valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor,),),) :
               
               
               
                AuthButton(
                  isFilled: false,
                  onTap: (){
Navigator.of(context)
.push(
  MaterialPageRoute(builder: (_)=> SignupScreen())
);

                  //go to signup screen
                },
                 buttonText: getTranslated('SIGN_UP', context)),),
            
            
            ],
          ),
        ),
      ),
    );


  }

}
