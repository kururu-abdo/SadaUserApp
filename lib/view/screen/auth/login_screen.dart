import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/auth/widget/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
 LoginScreen({ Key key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
resizeToAvoidBottomInset: false,
  body: Stack(
            clipBehavior: Clip.none,

    children:
[
 Consumer<AuthProvider>(
            builder: (context, auth, child) => 

               SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

SizedBox(height: Dimensions.topSpace),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Image.asset(Images.logo_with_name_image,
                     height: 300, 
                    
                    scale: 1.5,
                    ),
                  ),



  Expanded(
                    child:

                    SignInWidget()

  )










                ]))

 )




]
  )






    );
  }
}