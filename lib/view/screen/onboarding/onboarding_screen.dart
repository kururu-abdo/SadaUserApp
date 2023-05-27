import 'package:eamar_user_app/view/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/onboarding_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList(context);


    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: 
      SafeArea(
        child: Container(
      margin: EdgeInsets.only(top: 20),
      
          height: _height ,
      
        width: double.infinity,
    
      
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      
      Center(
        child: Image.asset(
          'assets/images/welcome_image.png'
        ),
      ) ,
      
      
      Container(
        height: _height/3, 
  
         padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   
Text(

  getLang(context)=='ar'?
  'شركة صدى الاعمار التجارية المحدودة ':
  'ECHO EMAAR TRADING COMPANY' ,
style: TextStyle(
  fontSize: 20 , fontWeight: FontWeight.bold ,
  color: Theme.of(context).primaryColor 
),
)
,
SizedBox(height: 5,) ,

  Container(
        height: (_height/3)*.80,
        width: MediaQuery.of(context).size.width,
        child: Text(

          getLang(context)=="ar"?
          'شركة صدى الاعمار التجارية المحدودة     شركة صدى الاعمار التجارية المحدودة   شركة صدى الاعمار التجارية المحدودة   شركة صدى الاعمار التجارية المحدودة شركة صدى الاعمار التجارية المحدودة  شركة صدى الاعمار التجارية المحدودة  شركة صدى الاعمار التجارية المحدودة  شركة صدى الاعمار التجارية المحدودة شركة صدى الاعمار التجارية المحدودة  شركة صدى الاعمار التجارية المحدودة ':
          'ECHO EMAAR TRADING COMPANY  , ECHO EMAAR TRADING  COMPANY , ECHO EMAAR TRADING COMPANY \n ECHO EMAAR TRADING COMPANY  , ECHO EMAAR TRADING COMAPANY \n ECHO EMAAR TRADING COMPANY  , ECHO EMAAR TRADING COMAPANY\n ECHO EMAAR TRADING COMPANY  , ECHO EMAAR TRADING COMAPANY  \n ECHO EMAAR TRADING COMPANY  , ECHO EMAAR TRADING COMAPANY\n ECHO EMAAR TRADING COMPANY  , ECHO EMAAR TRADING COMAPANY' ,

        //  overflow: TextOverflow.ellipsis,]


        style: TextStyle(
          fontSize: 16 , fontWeight: FontWeight.w500
        ),
        ), 


  )
,

          ],
        ),
      )
      
      ,

      Spacer(),









Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 70, vertical: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                          ])),
                      child: TextButton(
                        onPressed: () {
                          // if (Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex == onBoardingList.onBoardingList.length - 1) {
                            Provider.of<SplashProvider>(context, listen: false).disableIntro();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => 
                            // AuthScreen()
                          LoginScreen()  
                            
                            ));
                          // } else {
                          //   _pageController.animateToPage(Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex+1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                          // }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child:Text(  getTranslated('GET_STARTED', context) ,
                              style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                        ),
                      ),
                    ),











      SizedBox(height: 50,)
        ],
      ),
      
      
        ),
      )






      // Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     Provider.of<ThemeProvider>(context).darkTheme ? SizedBox() : Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       child: Image.asset(Images.background, fit: BoxFit.fill),
      //     ),
      //     Consumer<OnBoardingProvider>(
      //       builder: (context, onBoardingList, child) => ListView(
      //         children: [
      //           SizedBox(
      //             height: _height*0.7,
      //             child: PageView.builder(
      //               itemCount: onBoardingList.onBoardingList.length,
      //               controller: _pageController,
      //               itemBuilder: (context, index) {
      //                 return Padding(
      //                   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      //                   child: Column(
      //                     children: [
      //                       Image.asset(onBoardingList.onBoardingList[index].imageUrl, height: _height*0.5),
      //                       Text(onBoardingList.onBoardingList[index].title, style: titilliumBold.copyWith(fontSize: _height*0.035), textAlign: TextAlign.center),
      //                       Text(onBoardingList.onBoardingList[index].description, textAlign: TextAlign.center, style: titilliumRegular.copyWith(
      //                         fontSize: _height*0.015,
      //                       )),
      //                     ],
      //                   ),
      //                 );
      //               },
      //               onPageChanged: (index) {
      //                 onBoardingList.changeSelectIndex(index);
      //               },
      //             ),
      //           ),
      //           Column(
      //             children: [
      //               SizedBox(height: 50),
      //               Padding(
      //                 padding: const EdgeInsets.only(bottom: 20),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: _pageIndicators(onBoardingList.onBoardingList, context),
      //                 ),
      //               ),
      //               Container(
      //                 height: 45,
      //                 margin: EdgeInsets.symmetric(horizontal: 70, vertical: Dimensions.PADDING_SIZE_SMALL),
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(6),
      //                     gradient: LinearGradient(colors: [
      //                       Theme.of(context).primaryColor,
      //                       Theme.of(context).primaryColor,
      //                       Theme.of(context).primaryColor,
      //                     ])),
      //                 child: TextButton(
      //                   onPressed: () {
      //                     if (Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex == onBoardingList.onBoardingList.length - 1) {
      //                       Provider.of<SplashProvider>(context, listen: false).disableIntro();
      //                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
      //                     } else {
      //                       _pageController.animateToPage(Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex+1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      //                     }
      //                   },
      //                   child: Container(
      //                     width: double.infinity,
      //                     alignment: Alignment.center,
      //                     child: Text(onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1
      //                         ? getTranslated('GET_STARTED', context) : getTranslated('NEXT', context),
      //                         style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
   
   
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? 18 : 7,
          height: 7,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
