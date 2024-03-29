import 'dart:developer';
import 'dart:io';

import 'package:eamar_user_app/localization/app_localization.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/localization_provider.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';
import 'package:eamar_user_app/view/screen/branches/branches.dart';
import 'package:eamar_user_app/view/screen/dashboard/dashboard_screen.dart';
import 'package:eamar_user_app/view/screen/languages/languages.dart';
import 'package:eamar_user_app/view/screen/splash/index.dart';
import 'package:eamar_user_app/view/screen/splash/widget/available_on.dart';
import 'package:eamar_user_app/view/screen/splash/widget/brand_item.dart';
import 'package:eamar_user_app/view/screen/splash/widget/social_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({super.key});

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  Widget build(BuildContext context) {


   
    return  Scaffold(
    extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
appBar: PreferredSize(
  preferredSize:
  
  
  
   Size.fromHeight(
    
    isTablet(context)? 200: 
    150),
  child:   Hero(
    tag: 'bar',
    child: AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
 Navigator.of(context).push(
                MaterialPageRoute(builder: (_)=>LanguagePage())
                  );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          Text(context.read<LocalizationProvider>().locale.languageCode=="ar"?
          "عر":"En"
           ,
                
                
                style: TextStyle(
                  color: Colors.white ,fontSize: 
    isTablet(context)? 30:24
                ),
                ),
SizedBox(width: 3,),
                Icon(Icons.translate,size: 
    isTablet(context)? 30:24 , color: Colors.white,)
                // IconButton(onPressed: (){
                //   Navigator.of(context).push(
                // MaterialPageRoute(builder: (_)=>LanguagePage())
                //   );
                // }, icon: Icon(Icons.translate,size: 24 , color: Colors.white,)),
          
                
              ],
            ),
          ),
        )
      ],
      flexibleSpace: Center(
        child: Image.asset('assets/images/logo_with_name.png'  ,
         color: Colors.white ,),
      ),
    backgroundColor: Color(0xFFe69211),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(100)
        )
      ),
    ),
  ),
),





body: Column(
  children: [
Container(
  
  padding: 
  isTablet(context)?EdgeInsets.symmetric(
    vertical: 50 , 
  ):
  
  EdgeInsets.all(20),
  alignment: Alignment.topCenter,
  height: MediaQuery.of(context).size.height*.85,
decoration: BoxDecoration(
  color: Color(
    0xFFf7a11f


  ),
  borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(100)
      )
),


child: Center(
  child:
  
  isTablet(context)?
  
  ListView(
    children: [  


        Center(
      child: BrandItem(
        title:
        AppLocalization.of(context)!.translate("products")
        //  'Products'
         
         
         ,
        icon: 'assets/images/shopping-cart.png',
        onTap: (){
            Provider.of<AuthProvider>(context, listen: false).setUserType(
                          'visitor'
                        );
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashBoardScreen()));
        },
      ),
    ) ,
    
     Center(
       child: BrandItem(
        title:   AppLocalization.of(context)!.translate("branches"),
         icon: 'assets/images/pin.png',
        onTap: (){
          Navigator.of(context).push(
            
            MaterialPageRoute(builder: (_)=> BranchesPage())
          );
        },
       ),
     ),
    
   
    
     Center(
       child: BrandItem(
          icon: 'assets/images/user.png',
        title:   AppLocalization.of(context)!.translate("sign_in"),
        onTap: (){
  if(!Provider.of<AuthProvider>(context , listen: false)
  .isLoggedIn()){
  
   Navigator.of(context).push(
            MaterialPageRoute(builder: (_){
  
              return  AuthScreen();
            })
          );
  }else {
  Navigator.of(context).push(
            MaterialPageRoute(builder: (_){
  
              return  DashBoardScreen();
            })
          );
   
  }
         
        },
       ),
     ) ,
     Center(
       child: BrandItem(
        title:   AppLocalization.of(context)!.translate("contact_us"),
          icon: 'assets/images/whatsapp 2.png',
          onTap: (){
     
          log('Love Suzan');
           Navigator.of(context).push(
          MaterialPageRoute(builder: (_){
       
            return  IndexPage();
          })
        );
        },
       ),

       
     )
  
    ],
  ):
  
  GridView.count(crossAxisCount:
  
   2 ,  
  
  mainAxisSpacing:
  isTablet(context)?3:
   5, 
  crossAxisSpacing: isTablet(context)?5:10,
  
  children: 
  
  
  [
   
        Center(
      child: BrandItem(
        title:
        AppLocalization.of(context)!.translate("products")
        //  'Products'
         
         
         ,
        icon: 'assets/images/shopping-cart.png',
        onTap: (){
            Provider.of<AuthProvider>(context, listen: false).setUserType(
                          'visitor'
                        );
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashBoardScreen()));
        },
      ),
    ) ,
    
     Center(
       child: BrandItem(
        title:   AppLocalization.of(context)!.translate("branches"),
         icon: 'assets/images/pin.png',
        onTap: (){
          Navigator.of(context).push(
            
            MaterialPageRoute(builder: (_)=> BranchesPage())
          );
        },
       ),
     ),
    
   
    
     Center(
       child: BrandItem(
          icon: 'assets/images/user.png',
        title:   AppLocalization.of(context)!.translate("sign_in"),
        onTap: (){
  if(!Provider.of<AuthProvider>(context , listen: false)
  .isLoggedIn()){
  
   Navigator.of(context).push(
            MaterialPageRoute(builder: (_){
  
              return  AuthScreen();
            })
          );
  }else {
  Navigator.of(context).push(
            MaterialPageRoute(builder: (_){
  
              return  DashBoardScreen();
            })
          );
   
  }
         
        },
       ),
     ) ,
     Center(
       child: BrandItem(
      
        title:   AppLocalization.of(context)!.translate("contact_us"),
          icon: 'assets/images/whatsapp 2.png',
            onTap: (){
     
          log('Love Suzan');
           Navigator.of(context).push(
          MaterialPageRoute(builder: (_){
       
            return  IndexPage();
          })
        );
        },
       ),
     )
  
  
  
  ],
  
  
  ),
),
)

, 
Spacer(),

Column(
  crossAxisAlignment: CrossAxisAlignment.center , 

  children: [

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     AvailableOn(
    //       title: 'GET IT ON',
    //       storeName: 'Google Play',
    //       icon:"assets/images/google-play.png" ,

    //     ) , 
        
    //     AvailableOn(
    //       title: 'Available on',
    //       storeName: 'App Store',
    //         icon:"assets/images/apple.png" ,
    //     ),
    //   ],
    // ) , 
    
  
  SizedBox(height: 20,),
Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
children: [
  SocialLink(
icon: "assets/images/facebook-app-symbol.png",
  ) ,
  
  SizedBox(width: 10,)
  , SocialLink(
    icon: "assets/images/instagram-symbol.png",
  ) ,
  
  SizedBox(width: 10,), SocialLink(
    icon: "assets/images/google-plus-logo.png",
  ),
  
  SizedBox(width: 10,) , SocialLink(
     icon: "assets/images/twitter1.png",
  )
],
),
    // Spacer()  , 
  SizedBox(height: 10,),
    Text('الحقوق محفوظة لصدى الاعمار ' , style: TextStyle(

      fontSize: isTablet(context)?35:18,
      color: Colors.white ,fontWeight: FontWeight.w500 , 
    ),)
,
      SizedBox(height: 20,),

  ],
)

  ],
),
  
  
  
  
  
    );
  }
}