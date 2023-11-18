
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
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_textfield.dart';
import 'package:eamar_user_app/view/screen/auth/forget_password_screen.dart';
import 'package:eamar_user_app/view/screen/auth/signup_screen.dart';
import 'package:eamar_user_app/view/screen/auth/widget/mobile_verify_screen.dart';
import 'package:eamar_user_app/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validate_ksa_number/validate_ksa_number.dart';

import 'otp_verification_screen.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController? _emailController;
    late TextEditingController _phoneController;

  TextEditingController? _passwordController;
    TextEditingController? _idController;

  GlobalKey<FormState>? _formKeyLogin;

List<String> _metods = ['by_phone' ,'by_id'];
String? _selectedMethod;

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
 String _email =_countryDialCode.trim()+
                    
                    PhoneNumberUtils.getPhoneNumberFromInputs( _emailController!.text.trim())
                    ;
      String _password = _passwordController!.text.trim();
print(_email.toString());

  if (_selectedMethod=="by_id") {
    if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('id_is_required', context)!),
          backgroundColor: Colors.red,
        ));
      } 
      
  }
  else  if(_selectedMethod=="by_phone") {
if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } 
        else if (!ksaValidate.isValidNumber(_email)) {
                    log('is not valid Number');

 try {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('enter_valid_phone', context)!),
          backgroundColor: Colors.red,
        ));
 } catch (e) {
                       log('$e');

 }

                     // showCustomSnackBar(getTranslated('enter_valid_email', context), context);
                    }
  }

      
      
      
      else if (_password.isEmpty) {
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
 loginBody.method =  _selectedMethod; 
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
  String _countryDialCode = "+966";
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 
      Dimensions.MARGIN_SIZE_LARGE),
      child: Form(
        key: _formKeyLogin,
        child: Container(
            padding:
           EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),


          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        
            children: [
        
        
              // Container(
              //     margin:
              //     EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              //     child: CustomTextField(
              //       hintText: getTranslated('ENTER_YOUR_EMAIL', context),
              //       focusNode: _emailNode,
              //       nextNode: _passNode,
              //       textInputType: TextInputType.emailAddress,
              //       controller: _emailController,
              //     )),
        
          //for phone
        
        
          //  Container(
          //           margin: EdgeInsets.only(
          //               left: Dimensions.MARGIN_SIZE_LARGE,
          //               right: Dimensions.MARGIN_SIZE_LARGE,
          //               bottom: Dimensions.MARGIN_SIZE_SMALL),
          //           child: Row(
          //             children: [
          //               // CodePickerWidget(
          //               //   onChanged: (CountryCode countryCode) {
          //               //     _countryDialCode = countryCode.dialCode;
          //               //   },
          //               //   initialSelection: _countryDialCode,
          //               //   favorite: [_countryDialCode],
          //               //   showDropDownButton: true,
          //               //   padding: EdgeInsets.zero,
          //               //   showFlagMain: true,
          //               //   textStyle: TextStyle(
          //               //       color: Theme.of(context).textTheme.headline1.color),
          //               // ),
          //               Expanded(
          //                   child: Container(
          //                                margin:
          //               EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
          //                     child: CustomTextField(
          //                                     hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
          //                                     focusNode: _emailNode,
          //                                     nextNode: _passNode,
          //                                     controller: _emailController,
                                        
          //                                     isPhoneNumber: true,
          //                                     textInputAction: TextInputAction.next,
          //                                     textInputType: TextInputType.phone,
          //                                   ),
          //                   )),
          //             ],
          //           ),
          //         ),

// Align(alignment: AlignmentDirectional.centerStart,
//   child:   Row(
//     mainAxisSize: MainAxisSize.min,
//     children: [
  
//   GestureDetector(
//     onTap: (){
    
//                   _selectedMethod='by_id';
//                   setState(() {
            
//                   });
                
//     },
//     child: AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//     height: 50,
//     padding:  _selectedMethod =='by_id'?
    
//     EdgeInsets.all(8): EdgeInsets.only(
//       left: 8,right: 8,
//       top: 20) ,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     gradient:_selectedMethod =='by_id'? LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//       stops: [.1,  1 ],
//     colors: [Theme.of(context).primaryColor,
//     Colors.white
//     // Theme.of(context).primaryColor.withOpacity(.20),
//     ]): null,
//     ),
//     child:  Text(getTranslated('by_id', context)! ,
    
//     style: TextStyle(
//       color: Colors.black
//     ),
//     ),
//     ),
//   )
  
   
  
  
//   ,
//   GestureDetector(
//     onTap: (){
    
//                   _selectedMethod='by_phone';
//                   setState(() {
            
//                   });
                
//     },
//     child: AnimatedContainer(
//           duration: Duration(milliseconds: 200),
//     height: 50,
//     padding: 
//     _selectedMethod =='by_phone'?
    
//     EdgeInsets.all(8): EdgeInsets.only(
//       left: 8,right: 8,
//       top: 20)  ,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     gradient:_selectedMethod =='by_phone'? LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//      stops: [.1,  1 ],
//     colors: [Theme.of(context).primaryColor,
//     Colors.white
//     // Theme.of(context).primaryColor.withOpacity(.20),
//     ]):null,),
//     child:  Text(getTranslated('by_phone', context)! ,
    
//     style: TextStyle(
//       color: Colors.black
//     ),
//     ),
//     ),
//   )
  
   
   
//   ]),
// ) ,

//           Align(
// alignment: AlignmentDirectional.centerStart,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
          
          
          
          
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: (){
//                   _selectedMethod='by_id';
//                   setState(() {
            
//                   });
//                 },
//                 child: Container(
//               width: 20,height: 20
//               ,
//                   decoration: BoxDecoration(
              
              
//               border: Border.all(
//                 width: 1 , color: Theme.of(context).primaryColor
//               ) ,
//               color: _selectedMethod =='by_id'?
//                Theme.of(context).primaryColor:Colors.white
              
//                   ),
//               child:     Center(
// child:
//                      _selectedMethod =='by_id'?
//                      Icon(Icons.check  , size: 15 ,color: Colors.white,) 
//                      :SizedBox.shrink()
//                   ),
//                 ),
//               ),
          
          
//           SizedBox(width: 10,),
          
//               Text(getTranslated('by_id', context)!)
//             ],
          
          
          
//           ) ,
          
          
          
          
          
//           SizedBox(width: 20,)
          
          
//           ,
          
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: (){
//                   _selectedMethod='by_phone';
//                   setState(() {
            
//                   });
//                 },
//                 child: Container(
//               width: 20,height: 20,
//                   decoration: BoxDecoration(
              
              
//               border: Border.all(
//                 width: 1 , color: Theme.of(context).primaryColor
//               ) ,
//               color: _selectedMethod =='by_phone'?
//                Theme.of(context).primaryColor:Colors.white
              
//                   ),
//                   child: Center(
// child:
//                      _selectedMethod =='by_phone'?
//                      Icon(Icons.check  ,size: 15 ,color: Colors.white,) 
//                      :SizedBox.shrink()
//                   ),
//                 ),
//               ),
          
          
          
//           SizedBox(width: 10,),
          
//               Text(getTranslated('by_phone', context)!)
//             ],
          
          
          
//           ) ,
          




          
          
          
//               ],
//             ),
//           ),

             SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT
             ,),
        Container(


          decoration: BoxDecoration(
            boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
        ],
          ),
                                   margin:
                  EdgeInsets.only(
                    
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                       
                       
                        child:

                         AnimatedCrossFade(firstChild:
                          CustomTextField(
                                        hintText: getTranslated('enter_customer', context),
                                        focusNode: _idFocusNode,
                                        nextNode: _passNode,
                                        controller: _idController,
                                        
                                        isPhoneNumber: false,
                                        textInputAction: TextInputAction.next,
                                        textInputType: TextInputType.number,
                                        
                                      ),
                           secondChild: 
                           
                           CustomTextField(
                                        hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                                        focusNode: _emailNode,
                                        nextNode: _passNode,
                                        controller: _emailController,
                                        
                                        isPhoneNumber: true,
                                        textInputAction: TextInputAction.next,
                                        textInputType: TextInputType.phone,
                                      ), 
                           
                           
                           crossFadeState: _selectedMethod=="by_id"?
                           CrossFadeState.showFirst: 
                           CrossFadeState.showSecond
                           , 
                           duration: Duration(
                             milliseconds: 400
                           ))



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
        
        
        
              Container(
                margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Row(children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Checkbox(
                        checkColor: ColorResources.WHITE,
                        activeColor: Theme.of(context).primaryColor,
                        value: authProvider.isRemember,
                        onChanged: authProvider.updateRemember,),),
        
        
                    Text(getTranslated('REMEMBER', context)!,
                     style: titilliumRegular),
                  ],),
        
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPasswordScreen())),
                      child: Text(getTranslated('FORGET_PASSWORD', context)!,
                          style: titilliumRegular.copyWith(
                          color: ColorResources.getLightSkyBlue(context))),
                    ),
                  ],
                ),
              ),
        
        
        
              Container(



                // margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
                
                   margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                
                child: Provider.of<AuthProvider>(context).isLoading ?
                Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor,),),) :
                CustomButton(onTap: loginUser,
                 buttonText: getTranslated('SIGN_IN', context)),),
            
            
            
            
            
              SizedBox(height: 8),
        
               Container(
                    margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                 child: Align(
               
                   alignment: getLang(context)=="ar"?
                   Alignment.centerLeft: 
                     Alignment.centerRight
                   ,
                   child:    getLang(context)=="ar"?
                   
                   
                  RichText(
                  text:  TextSpan(
                      text: 'ليس لديك حساب؟' ,
                      
                      style:  titilliumRegular.copyWith(
                 color:      Provider.of<ThemeProvider>(context).darkTheme? 
                        
                        
                        
                      Colors.white :Colors.black,


                          fontSize: 16 ,fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                          text: 'إنشاء حساب' ,
                          recognizer:   TapGestureRecognizer()..onTap = () {
                        

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>   
                           SignupScreen()
                        ));
                      },
                          style: TextStyle(
                            fontSize: 18 , fontWeight: FontWeight.w500 ,
                            color: Theme.of(context).primaryColor
                          )
                        )
                      ]
                    )
                  ):
               
              RichText(
                text:    TextSpan(
                      text: 'You don\'t have an accoount? ' ,
                      style: titilliumRegular.copyWith(
                        fontSize: 16 ,
                        fontWeight: FontWeight.w500 ,


                     

                        color: 
                        
                          Provider.of<ThemeProvider>(context).darkTheme? 
                        
                        
                        
                      Colors.white :Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: 'create account' ,
recognizer:   TapGestureRecognizer(

  
)..onTap = () {
                        

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>   
                           SignupScreen()
                        ));
                      },
                          
                          style: TextStyle(
                            fontSize: 18 , fontWeight: FontWeight.w500 ,
                            color: Theme.of(context).primaryColor
                          ),
                          
                        )
                      ]
                    )
                  )
               
                   
                     ,
                 ),
               ),
        
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
          
          
          
            ],
          ),
        ),
      ),
    );


  }

}
