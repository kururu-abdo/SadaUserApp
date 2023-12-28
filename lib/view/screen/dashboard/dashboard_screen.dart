import 'dart:developer';

import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/responsive.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/screen/cart/cart_screen.dart';
import 'package:eamar_user_app/view/screen/splash/brand_page.dart';
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
import 'package:hidable/hidable.dart';
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
late final ScrollListener _model;
  late final ScrollController _controller;
  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

   version = Provider.of<SplashProvider>(context,listen: false).configModel!.version != null?
      Provider.of<SplashProvider>(context,listen: false).configModel!.version:'version';
_controller = ScrollController();
    _model = ScrollListener.initialise(_controller);

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
  String? version;
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
floatingActionButton:isTablet(context)?  SizedBox(): new Hidable(
  controller: homeScrollController,
  // preferredWidgetSize: Size.fromHeight(100),
  child: 
  isTablet(context)?


    FittedBox(
      child: FloatingActionButton.large(
      
      
       onPressed:(){
        
        
        Navigator.of(context) 
        .push(
      MaterialPageRoute(builder: 
      
      (_)=>CartScreen()
      )
        );
        
        },
        
        child: Center(
      child: ImageIcon(
        AssetImage(Images.cart_image),
        
        
        color: Colors.white,
        size:  50,
        
      ),
        ),
        
        ),
    ):

    FloatingActionButton(
    
    
     onPressed:(){
  
  
  Navigator.of(context) 
  .push(
    MaterialPageRoute(builder: 
    
    (_)=>CartScreen()
    )
  );
  
  },
  
  child: Center(
    child: ImageIcon(
      AssetImage(Images.cart_image),
      
      
      color: Colors.white,
      size: isDesktop(context)? 50: 25,
      
    ),
  ),
  
  ),



),

        // backgroundColor: Colors.transparent,
        bottomNavigationBar:
           isTablet(context)?  SizedBox():
new Hidable(
  controller: homeScrollController,
  preferredWidgetSize: 
  
  isTablet(context)?Size.fromHeight(150):
  Size.fromHeight(100),
  child:  
  // Container(
  //   height: 50, width: 400 ,color: Colors.green,
  // )

  BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(singleVendor),
          onTap: (int index) {
            _setPage(index);
          },

  )
  //  BottomAppBar(
  //           shape: CircularNotchedRectangle(),
  //           // height: 100,
  // color: Colors.white,
  
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  // children:  [
  
  
  //   GestureDetector(
  //     onTap: (){

  //       //  _setPage(0);
    
  //                     log("HOME");
  //     },
  //     child: IconButton(
  //                   icon: ImageIcon(
  //                     AssetImage(Images.home_image ,
                      
                      
  //                     ),
  //                     color: Theme.of(context).primaryColor,
      
  //                     size: 30,
  //                   ),
  //                   color: Colors.black,
  //                   onPressed: () {
  //                     _setPage(0);
    
  //                     log("HOME");
  //                   },
  //                 ),
  //   ),
              
              
              
              
  //              IconButton(
  //                 icon: ImageIcon(
  //                   AssetImage(Images.shopping_image ,)
  //                   ,color: Theme.of(context).primaryColor,
  //                 ),
  //                 color: Colors.black,
  //                 onPressed: () {
  //                   _setPage(1);
  //                   setState(() {
                      
  //                   });
  //                 },
  //               )
              
             
                
  //               ,
  //               SizedBox(
  //                 width: 40,
  //               ),
  //                IconButton(
  //                 icon: ImageIcon(
  //                   AssetImage(Images.jobs_icon ,)
  //                   ,color: Theme.of(context).primaryColor,
  //                 ),
  //                 color: Colors.black,
  //                 onPressed: () {
  //                   _setPage(2);
  //                 },
  //               )
              
             
                
                
  //               ,
  //                 IconButton(
  //                 icon: ImageIcon(
  //                   AssetImage(Images.more_image ,)
  //                   ,color: Theme.of(context).primaryColor,
  //                 ),
  //                 color: Colors.black,
  //                 onPressed: () {
  //                   _setPage(3);
  //                 },
  //               )
              
  //            ,
  // ]
  //           )
            
  //           ),



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
      
      
      
      
        body:
        // _screens[_pageIndex]

         isTablet(context)?  
         Row(
children: [
Container(
  padding: EdgeInsets.only(
    // top: MediaQuery.of(context).viewPadding.top
  ),
  width: MediaQuery.of(context).size.width/5,
  height: MediaQuery.of(context).size.height,
  // color: Colors.red,

  child: Column(children: [  
 GestureDetector(
    onTap: (){


                          // Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
                            Navigator.of(context).
                            pushAndRemoveUntil(
                              
                              MaterialPageRoute(builder: (BuildContext context) =>
                               BrandPage()), 
                               
                               
                               (route)=>false
                               );

                      },
   child: Hero(
    tag: 'bar',
     child: Image.asset(Images.logo_with_name_image,
                            
                            
                             height:isTablet(context)? 200: 100 ,scale: 1.2,),
   ),
 )
, 
SizedBox(height: 50,)

//menue
,
_getMenuBar(false),


  ],),
)
,  

Expanded(child: 
 PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            log(index.toString());
            return _screens[index];
          },
        ),

)
],

         ):
         PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            log(index.toString());
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
        height: 
          isTablet(context)?50:
        25, width:  isTablet(context)?50: 25,
      ),
      label: label,
    );
  }
Widget _menuItem(String icon, String? label, int index){
  return GestureDetector(
    onTap: (){

      _pageIndex=index;
       _setPage(index);
      setState((){});
    },
    child: Center(
      child: AnimatedContainer(duration: Duration(milliseconds: 200) , 
      padding: EdgeInsets.all(8),
      height: 
           index == _pageIndex ?120:
            80, width: index == _pageIndex ?120:
            80,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50)
              shape: BoxShape.circle
              
              ,
      color: _pageIndex==index? Theme.of(context).primaryColor:Colors.transparent
      
            ),
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      ImageIcon(AssetImage(icon),size: index == _pageIndex? 25:50,   color: index == _pageIndex ?
      Colors.white:
           Colors.black ), 
      index == _pageIndex ?
      SizedBox(height: 3,):SizedBox.shrink(),
          index == _pageIndex ?
    
          Text(label!,overflow: TextOverflow.ellipsis,  style: TextStyle(color: Colors.white , fontSize:
          index == _pageIndex?15:
          
           18),):SizedBox.shrink()
        ],
      ),
      ),
      
      
      ),
    ),
  );
}




  void _setPage(int pageIndex) {
    log(pageIndex.toString());
    
      _pageIndex = pageIndex;
       _pageController.jumpToPage(pageIndex);
    setState(() {
     
    });
  }



  Widget _getMenuBar(bool isSingleVendor) {
    List<(String, String?,int)> _list = [];

    // if(!isSingleVendor){
    //   _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
    //   _list.add(_barItem(Images.message_image, getTranslated('inbox', context), 1));

    //   _list.add(_barItem(Images.shopping_image, getTranslated('orders', context), 2));

    //               _list.add(_barItem(Images.jobs_icon,
    //                getTranslated('jobs_txt', context), 3));

    //   _list.add(_barItem(Images.notification, getTranslated('notification', context), 4));
    //   _list.add(_barItem(Images.more_image, getTranslated('more', context),5));
    // }else{
      _list.add((Images.home_image, getTranslated('home', context), 0));
      _list.add((Images.shopping_image, getTranslated('orders', context), 1));
      _list.add((Images.jobs_icon,
       getTranslated('jobs_txt', context), 2));

      // _list.add(_barItem(Images.notification, getTranslated('notification', context), 3));
      _list.add((Images.more_image, getTranslated('more', context), 4));



      
    // }

    return Expanded(child: ListView(children: 
    
    _list.asMap().map((i, element) => MapEntry(i,   _menuItem(element.$1,
     element.$2, element.$3))).values.toList()
    
    
    
    ,))
;  }






  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> _list = [];

    // if(!isSingleVendor){
    //   _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
    //   _list.add(_barItem(Images.message_image, getTranslated('inbox', context), 1));

    //   _list.add(_barItem(Images.shopping_image, getTranslated('orders', context), 2));

    //               _list.add(_barItem(Images.jobs_icon,
    //                getTranslated('jobs_txt', context), 3));

    //   _list.add(_barItem(Images.notification, getTranslated('notification', context), 4));
    //   _list.add(_barItem(Images.more_image, getTranslated('more', context),5));
    // }else{
      _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
      _list.add(_barItem(Images.shopping_image, getTranslated('orders', context), 1));
      _list.add(_barItem(Images.jobs_icon,
       getTranslated('jobs_txt', context), 2));

      // _list.add(_barItem(Images.notification, getTranslated('notification', context), 3));
      _list.add(_barItem(Images.more_image, getTranslated('more', context), 4));



      
    // }

    return _list;
  }

}