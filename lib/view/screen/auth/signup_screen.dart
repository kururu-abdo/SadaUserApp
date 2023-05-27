import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/view/screen/auth/widget/sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/auth/widget/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SignupScreen extends StatefulWidget {
const SignupScreen({ Key? key }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
 appBar: AppBar(title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios,
                
                //  color: Theme.of(context).cardColor,
                 
                 
                  size: 20),
                onTap: () => Navigator.pop(context),),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


              Text(getLang(context)=="ar"?
            "إنشاء حساب" :
              'New account'
              
              ,

              
                  style: robotoRegular.copyWith(fontSize: 20,
                      // color: Theme.of(context).cardColor
                      
                      )
                      
                      
                      ),
            ]),

            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: 
          Colors.transparent  
            // Provider.of<ThemeProvider>(context).darkTheme ?
            //  Colors.black : Theme.of(context).primaryColor,
          ),


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

                    SignUpWidget()

  )


















],



              

               

              )
               ))

 ])
    );
  }
}