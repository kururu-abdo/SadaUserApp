import 'dart:developer';

import 'package:eamar_user_app/view/screen/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/helper/network_info.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/view/screen/chat/inbox_screen.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/home/home_screens.dart';
import 'package:eamar_user_app/view/screen/jobs/jobs_page.dart';
import 'package:eamar_user_app/view/screen/more/more_screen.dart';
import 'package:eamar_user_app/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens ;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";




log(singleVendor.toString());
    _screens = [
      HomePage(),

       singleVendor?
       OrderScreen(isBacButtonExist: false): 
       InboxScreen(isBackButtonExist: false) ,

      // singleVendor? 
      // NotificationScreen(isBacButtonExist: false):
      //  OrderScreen(isBacButtonExist: false),
// SizedBox(width: 40,),

           JobsPage(isBacButtonExist: false),
    //  singleVendor? 
    //   NotificationScreen(isBacButtonExist: false):
    //    OrderScreen(isBacButtonExist: false),



    //   singleVendor? MoreScreen():
    //    NotificationScreen(isBacButtonExist: false),
      // singleVendor?SizedBox(): 
      
      MoreScreen()

      // singleVendor?OrderScreen(isBacButtonExist: false): InboxScreen(isBackButtonExist: false) ,

      // singleVendor?OrderScreen(isBacButtonExist: false): InboxScreen(isBackButtonExist: false) ,
      // singleVendor?JobsPage(isBacButtonExist: false): JobsPage(isBackButtonExist: false) ,

      // singleVendor? NotificationScreen(isBacButtonExist: false): OrderScreen(isBacButtonExist: false),
      // singleVendor? MoreScreen(): NotificationScreen(isBacButtonExist: false),
      // singleVendor?SizedBox(): MoreScreen(),
    ];

    NetworkInfo.checkConnectivity(context);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_pageIndex != 0) {
          _setPage(0);
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,

floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: FloatingActionButton( onPressed:(){


Navigator.of(context) 
.push(
  MaterialPageRoute(builder: 
  
  (_)=>CartScreen()
  )
);

},

child: Center(
  child: ImageIcon(
    AssetImage(Images.cart_image),color: Colors.white,
  ),
),

),

        // backgroundColor: Colors.transparent,
        bottomNavigationBar:
        
BottomAppBar(
          shape: CircularNotchedRectangle(),
          height: 100,


          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
children:  [


  IconButton(
                icon: ImageIcon(
                  AssetImage(Images.home_image ,
                  
                  
                  ),
                  color: Theme.of(context).primaryColor,

                  size: 30,
                ),
                color: Colors.black,
                onPressed: () {
                  _setPage(0);
                },
              ),
            
            
            
            
             IconButton(
                icon: ImageIcon(
                  AssetImage(Images.shopping_image ,)
                  ,color: Theme.of(context).primaryColor,
                ),
                color: Colors.black,
                onPressed: () {
                  _setPage(1);
                },
              )
            
           
              
              ,
              SizedBox(
                width: 40,
              ),
               IconButton(
                icon: ImageIcon(
                  AssetImage(Images.jobs_icon ,)
                  ,color: Theme.of(context).primaryColor,
                ),
                color: Colors.black,
                onPressed: () {
                  _setPage(2);
                },
              )
            
           
              
              
              ,
                IconButton(
                icon: ImageIcon(
                  AssetImage(Images.more_image ,)
                  ,color: Theme.of(context).primaryColor,
                ),
                color: Colors.black,
                onPressed: () {
                  _setPage(3);
                },
              )
            
           ,
]
          )
          
          ),

        //  BottomNavigationBar(
        //   selectedItemColor: Theme.of(context).primaryColor,
        //   unselectedItemColor: Theme.of(context).textTheme.bodyText1!.color,
        //   showUnselectedLabels: true,
        //   currentIndex: _pageIndex,
        //   type: BottomNavigationBarType.fixed,
        //   items: _getBottomWidget(singleVendor),
        //   onTap: (int index) {
        //     _setPage(index);
        //   },
        // ),
      
      
      
      
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, color: index == _pageIndex ?
      Theme.of(context).primaryColor :
       Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
        height: 25, width: 25,
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> _list = [];

    if(!isSingleVendor){
      _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
      _list.add(_barItem(Images.message_image, getTranslated('inbox', context), 1));

      _list.add(_barItem(Images.shopping_image, getTranslated('orders', context), 2));

                  _list.add(_barItem('assets/images/office.png', getTranslated('jobs_txt', context), 3));

      _list.add(_barItem(Images.notification, getTranslated('notification', context), 4));
      _list.add(_barItem(Images.more_image, getTranslated('more', context),5));
    }else{
      _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
      _list.add(_barItem(Images.shopping_image, getTranslated('orders', context), 1));
      _list.add(_barItem('assets/images/office.png',
       getTranslated('jobs_txt', context), 2));

      // _list.add(_barItem(Images.notification, getTranslated('notification', context), 3));
      _list.add(_barItem(Images.more_image, getTranslated('more', context), 4));



      
    }

    return _list;
  }

}