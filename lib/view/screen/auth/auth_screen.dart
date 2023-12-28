import 'package:eamar_user_app/provider/cart_provider.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/screen/auth/widget/audience_login.dart';
import 'package:eamar_user_app/view/screen/auth/widget/customer_login.dart';
import 'package:eamar_user_app/view/screen/dashboard/dashboard_screen.dart';
import 'package:eamar_user_app/view/screen/splash/brand_page.dart';
import 'package:flutter/material.dart';

import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/auth/widget/sign_in_widget.dart';
import 'package:eamar_user_app/view/screen/auth/widget/sign_up_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget{
  final int initialPage;
  AuthScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    PageController _pageController = PageController(initialPage: initialPage);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor:
      // ColorResources.LIGHT_SKY_BLUE
      
      // Color(0xFFeeeff3)
      // ,
      body: Stack(
        clipBehavior: Clip.none,
        children: [

          // Provider.of<ThemeProvider>(context).darkTheme ? SizedBox() 
          //     : Image.asset(Images.background, fit: BoxFit.fill,
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width),

          Consumer<AuthProvider>(
            builder: (context, auth, child) => 
            
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.topSpace),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_)=> BrandPage()),
                        (route)=>false
                      );
                    },
                    child: Image.asset(Images.logo_with_name_image, height:  isTablet(context)? 250: 200, 
                    
                    scale: 1.5,
                    ),
                  ),

SizedBox(height: 15,),

Padding(
  padding:    EdgeInsets.symmetric(horizontal: 10, vertical: 5)
  
  // .copyWith(bottom:  MediaQuery.of(context).viewInsets.bottom)
  ,
  child:   Container(
    padding:   const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    height: MediaQuery.of(context).size.height/1.8,
    width:  MediaQuery.of(context).size.width,
decoration: BoxDecoration(
  border: Border.all(
    width: .3  , color: Colors.grey , style: BorderStyle.solid
  )
),

child: Column(
  children: [
SizedBox(height: 10,),


Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
Text(getLang(context)=="ar"?  "تسجيل الدخول ":"Login"
            
            , style: TextStyle(
              
              fontSize:  isTablet(context)? 24: 18,
              color:
            
         
             Colors.black , fontWeight: FontWeight.bold),
            ),


            GestureDetector(
              onTap: (){

                if (!Provider.of<AuthProvider>(context, listen: false).isLoading) {
                    Provider.of<CartProvider>(context, listen: false).getCartData();
                          Provider.of<AuthProvider>(context, listen: false).setUserType(
                            'visitor'
                          );
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashBoardScreen()),
                            (route) => false);
                  }
              },
              child: Row(mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            ImageIcon(AssetImage('assets/images/guest.png') , size:
            isTablet(context)? 30: 
            
             20 , 
            
            
            ),
            SizedBox(width: 4,),
            Text(getLang(context)=="ar"?  "المتابعة كزائر":"continue as guest"
              
              , style: TextStyle(
                fontSize:  isTablet(context)? 20: 15,
                color:
              
                     
               Color(0xFFe58f35) , fontWeight: FontWeight.bold),
              ),
              ],
              ),
            )





  ],
)




,SizedBox(height: 10,)
,
Divider(
  color: Color(0xFFeeeeee),
)
,

SizedBox(height: 10,),
  Consumer<AuthProvider>(
                          builder: (context,authProvider,child) {
    return     Container(
      height: 55 ,width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF959ba7), borderRadius: BorderRadius.circular(50)
      ),
    padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
    
        children: [
     Expanded(
     child: GestureDetector(
      onTap: (){
        _pageController.animateToPage(0, duration: Duration(milliseconds: 210), curve: Curves.easeInOut);
      },
       child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
          height: 55 ,
          decoration: BoxDecoration(
            color:
             authProvider.selectedIndex == 0?
            
             Colors.white:
                 
             Color(0xFF959ba7)
            
            , borderRadius: BorderRadius.circular(50) , 
          ),
          child: Center(child: Text(getLang(context)=="ar"?  "تسجيل دخول الجمهور":"Audience login"
          
          , style: TextStyle(color:
          
           authProvider.selectedIndex == 0?
           Colors.black:Colors.white , 
           
           fontWeight: FontWeight.bold,
           fontSize: 15
           
           ),
          ),),
       ),
     ),
     ), 
    Expanded(
    child:   GestureDetector(
      onTap: (){

          _pageController.animateToPage(1, duration: Duration(milliseconds: 210), curve: Curves.easeInOut);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
          height: 55 ,
          decoration: BoxDecoration(
            color:
               authProvider.selectedIndex == 1?Colors.white:
            
            
             Color(0xFF959ba7)
            , borderRadius: BorderRadius.circular(50)
          ),
      
      child: Center(child: Text(getLang(context)=="ar"?  "تسجيل دخول عميل الشركة":"Customer login"
          
          , style: TextStyle(color: 
          
          
           authProvider.selectedIndex == 1?
          Colors.black:Colors.white ,
          
           fontWeight: FontWeight.bold,
           fontSize: 15
          
          ),
          ),),
      
       ),
    ),
    ), 
    
    
        ],
      ),
    );
  }
), 

SizedBox(height: 10,),


                  Expanded(
                    child: Consumer<AuthProvider>(
                      builder: (context,authProvider,child)=>PageView.builder(
                        itemCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          if (authProvider.selectedIndex == 0) {
                            return AudeienceLogin();
                          } else {
                            return CustomerLogin();
                          }
                        },
                        onPageChanged: (index) {
                          authProvider.updateSelectedIndex(index);
                        },
                      ),
                    ),
                  ),

               


  ],
),

  ),
  
),



                  // Padding(
                  //   padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
                  //   child: Stack(
                  //     clipBehavior: Clip.none,
                  //     children: [
                  //       Positioned(bottom: 0,
                  //         right: Dimensions.MARGIN_SIZE_EXTRA_SMALL, left: 0,
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: 1, color: ColorResources.getGainsBoro(context),
                  //         ),
                  //       ),


                  //       Consumer<AuthProvider>(
                  //         builder: (context,authProvider,child)=>Row(
                  //           children: [
                  //             InkWell(
                  //               onTap: () => _pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.easeInOut),
                  //               child: Column(
                  //                 children: [
                  //                   Text(getTranslated('SIGN_IN', context)!,
                  //                       style: authProvider.selectedIndex == 0 ?
                  //                       titilliumSemiBold : titilliumRegular),
                  //                   Container(
                  //                     height: 1, width: 40,
                  //                     margin: EdgeInsets.only(top: 8),
                  //                     color: authProvider.selectedIndex == 0 ?
                  //                     Theme.of(context).primaryColor : Colors.transparent,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),


                  //             InkWell(
                  //               onTap: () => _pageController.animateToPage(1,
                  //                   duration: Duration(seconds: 1), curve: Curves.easeInOut),
                  //               child: Column(
                  //                 children: [

                  //                   Text(getTranslated('SIGN_UP', context)!,
                  //                       style: authProvider.selectedIndex == 1 ?
                  //                       titilliumSemiBold : titilliumRegular),

                  //                   Container(height: 1, width: 50,
                  //                       margin: EdgeInsets.only(top: 8),
                  //                       color: authProvider.selectedIndex == 1 ?
                  //                       Theme.of(context).primaryColor : Colors.transparent
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),

                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),


               
               
               
               
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}































