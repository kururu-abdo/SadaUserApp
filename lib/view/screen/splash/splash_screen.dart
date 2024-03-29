import 'dart:async';
import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/helper/firebase_dynamic_links_services.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:eamar_user_app/view/screen/auth/login_screen.dart';
import 'package:eamar_user_app/view/screen/languages/languages.dart';
import 'package:eamar_user_app/view/screen/product/product_details_from_url.dart';
import 'package:eamar_user_app/view/screen/splash/brand_page.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/screen/dashboard/dashboard_screen.dart';
import 'package:eamar_user_app/view/screen/maintenance/maintenance_screen.dart';
import 'package:eamar_user_app/view/screen/onboarding/onboarding_screen.dart';
import 'package:eamar_user_app/view/screen/splash/widget/splash_painter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:uni_links/uni_links.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
 Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;















Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = (await getInitialLink())!;
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
if (initialLink.contains('product')) {
  
}



    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }







  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
WidgetsBinding.instance.addPostFrameCallback((_) {
 _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? getTranslated('no_connection', context)! : getTranslated('connected', context)!,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
_route();
});
        }
      }
      _firstTime = false;
    });
WidgetsBinding.instance.addPostFrameCallback((_) {
_route();
});
});
   
    
  }

  @override
  void dispose() {
      _onConnectivityChanged.cancel();
    super.dispose();

  
  }

  void _route() {
    DymanicLinksServices.initDynamicLink(context);
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AuthScreen()));

    Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((bool isSuccess) {
      log("RESULT"+ isSuccess.toString());

      if(isSuccess) {
        Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
        Timer(Duration(seconds: 1), () {

          
          if(Provider.of<SplashProvider>(context, listen: false).configModel!.maintenanceMode!) {
       
 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MaintenanceScreen()));


          }else {

  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>
  
  
  //  ProductDetailsFromUrl(
  //    slug: AppConstants.SLUG,
  //  )));
  Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context, isFromSplash: true);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BrandPage()));

  //           if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {



  //             Provider.of<AuthProvider>(context, listen: false).updateToken(context);
  //             Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
  //                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BrandPage()));

  //             // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
  //           } else {
  //             if(Provider.of<SplashProvider>(context, listen: false).showIntro()!) {
  //               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen(
  //                 indicatorColor: ColorResources.GREY, selectedIndicatorColor: Theme.of(context).primaryColor,
  //               )));
  //             }else {
  //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

  //               // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  //             }
  //           }



          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Provider.of<SplashProvider>(context).hasConnection ?
       Stack(
        clipBehavior: Clip.none, children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   color:Colors.black
            
          // //   Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : ColorResources.getPrimary(context)
             
          //    ,
          //   child: CustomPaint(
          //     painter: SplashPainter(),
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.logo_image, height: 250.0, 
                // fit: BoxFit.scaleDown,
                  // width: 250.0, 
                  //color: Theme.of(context).cardColor,
                  scale: 1.5,
                  ),
              ],
            ),
          ),
        ],
      ) : NoInternetOrDataScreen(isNoInternet: true, child: SplashScreen()),
    );
  }

}
