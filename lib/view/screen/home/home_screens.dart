import 'dart:developer';
import 'dart:io';

import 'package:eamar_user_app/helper/product_type.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/banner_provider.dart';
import 'package:eamar_user_app/provider/brand_provider.dart';
import 'package:eamar_user_app/provider/cart_provider.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/provider/featured_deal_provider.dart';
import 'package:eamar_user_app/provider/flash_deal_provider.dart';
import 'package:eamar_user_app/provider/home_category_product_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/provider/top_seller_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/utill/responsive.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/basewidget/title_row.dart';
import 'package:eamar_user_app/view/screen/brand/all_brand_screen.dart';
import 'package:eamar_user_app/view/screen/cart/cart_screen.dart';
import 'package:eamar_user_app/view/screen/category/all_category_screen.dart';
import 'package:eamar_user_app/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:eamar_user_app/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:eamar_user_app/view/screen/home/widget/announcement.dart';
import 'package:eamar_user_app/view/screen/home/widget/banners_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/brand_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_view2.dart';
import 'package:eamar_user_app/view/screen/home/widget/discount_products_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/featured_deal_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/featured_product_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/flash_deals_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/footer_banner.dart';
import 'package:eamar_user_app/view/screen/home/widget/home_category_product_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/latest_product_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/main_section_banner.dart';
import 'package:eamar_user_app/view/screen/home/widget/new_arrival_products.dart';
import 'package:eamar_user_app/view/screen/home/widget/product_view_listview.dart';
import 'package:eamar_user_app/view/screen/home/widget/products_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/recommended_product_view.dart';
import 'package:eamar_user_app/view/screen/home/widget/top_seller_view.dart';
import 'package:eamar_user_app/view/screen/notification/notification_screen.dart';
import 'package:eamar_user_app/view/screen/product/view_all_product_screen.dart';
import 'package:eamar_user_app/view/screen/search/new_search_page.dart';
import 'package:eamar_user_app/view/screen/search/search_screen.dart';
import 'package:eamar_user_app/view/screen/splash/brand_page.dart';
import 'package:eamar_user_app/view/screen/topSeller/all_top_seller_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
  final ScrollController homeScrollController = ScrollController();


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isGuestMode;
  // final ScrollController _scrollController = ScrollController();
final  ImageLabeler labeler = GoogleVision.instance.imageLabeler(
    
    ImageLabelerOptions
    
    
    (confidenceThreshold: 0.70),
);
  Future<void> _loadData(BuildContext context, bool reload) async {
isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();


if (!isGuestMode) {
   Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
}
 FirebaseAnalytics.instance
 .logEvent(name: 'LoadingData' ,
 
 parameters: {
   'time':DateTime.now()
 }
 );

Future.wait(
  [

  Provider.of<BannerProvider>(context, listen: false).getBannerList(reload, context),
     Provider.of<BannerProvider>(context, listen: false).getFooterBannerList(context),
     Provider.of<BannerProvider>(context, listen: false).getMainSectionBanner(context),
     Provider.of<CategoryProvider>(context, listen: false).getCategoryList(reload, context),
     Provider.of<HomeCategoryProductProvider>(context, listen: false).getHomeCategoryProductList(reload, context),
     Provider.of<TopSellerProvider>(context, listen: false).getTopSellerList(reload, context),
     Provider.of<BrandProvider>(context, listen: false).getBrandList(reload, context),
    
    //  Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, context, reload: reload),
    

     Provider.of<ProductProvider>(context, listen: false).getDiscountProducts(1, context, reload: reload),
     Provider.of<ProductProvider>(context, listen: false).getnewArriavalProducts(1,
      context, reload: false),


     Provider.of<ProductProvider>(context, listen: false).getFeaturedProductList('1', context, reload: reload),
     
     Provider.of<FeaturedDealProvider>(context, listen: false).getFeaturedDealList(reload, context),
     Provider.of<ProductProvider>(context, listen: false).getLProductList('1', context, reload: reload),
     Provider.of<ProductProvider>(context, listen: false).getRecommendedProduct(context),

Future.delayed(Duration.zero ,
()async{
 if ( Provider.of<AuthProvider>(context, listen: false).getUserType()!='visitor') {
           await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);

     }
})
    
  ]
);

    // await Provider.of<BannerProvider>(context, listen: false).getBannerList(reload, context);
    //  Provider.of<BannerProvider>(context, listen: false).getFooterBannerList(context);
    //  Provider.of<BannerProvider>(context, listen: false).getMainSectionBanner(context);
    //  Provider.of<CategoryProvider>(context, listen: false).getCategoryList(reload, context);
    //  Provider.of<HomeCategoryProductProvider>(context, listen: false).getHomeCategoryProductList(reload, context);
    //  Provider.of<TopSellerProvider>(context, listen: false).getTopSellerList(reload, context);
    //  Provider.of<BrandProvider>(context, listen: false).getBrandList(reload, context);
    //  Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, context, reload: reload);
    //  Provider.of<ProductProvider>(context, listen: false).getFeaturedProductList('1', context, reload: reload);
    //  Provider.of<FeaturedDealProvider>(context, listen: false).getFeaturedDealList(reload, context);
    //  Provider.of<ProductProvider>(context, listen: false).getLProductList('1', context, reload: reload);
    //  Provider.of<ProductProvider>(context, listen: false).getRecommendedProduct(context);


    //  if ( Provider.of<AuthProvider>(context, listen: false).getUserType()!='visitor') {
    //        await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);

    //  }
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

     _controller = ScrollController();
    _model = ScrollListener.initialise(homeScrollController);

   Future.microtask(() {
 singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";
setState(() {
  
});
 log("MODE" + Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode.toString());
    Provider.of<FlashDealProvider>(context, listen: false).getMegaDealList(true, context, true);

    _loadData(context, false);

    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<CartProvider>(context, listen: false).uploadToServer(context);
      Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
            Provider.of<AuthProvider>(context, listen: false).updateDeviceToken();

    }else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
   });

    });

    

  }
  PickedFile? _image;
bool _loading = false ;
List<dynamic>? _outputs;
final ImagePicker _picker = ImagePicker();




late final ScrollListener _model;
  late final ScrollController _controller;

// //load labels
// static Future<ClassifierLabels> _loadLabels(String labelsFileName) async {
//   // #1
//   final rawLabels = await FileUtil.loadLabels(labelsFileName);

//   // #2
//   final labels = rawLabels
//     .map((label) => label.substring(label.indexOf(' ')).trim())
//     .toList();

//   debugPrint('Labels: $labels');
//   return labels;
// }








classifyImage(image) async {
    final GoogleVisionImage visionImage = 
    GoogleVisionImage.fromFile(

      File(image.path)
    );
final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();

final VisionText visionText = await textRecognizer.processImage(visionImage);
// log(
// visionText.text!.toString());
var     results = await labeler.processImage(
  visionImage
  
  
  );

setState(() {_loading = false;//Declare List _outputs in the class which will be used to show the classified classs name and confidence
  _outputs = results;
 });
_outputs!.forEach((element) {
  
  log(element.text);
});
_modalSheetResults();
}


 Future openCamera() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = image ;
    });
    classifyImage(image);
  }

  //camera method
  Future openGallery() async {
    var piture = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = piture;
    }
     
    );
    classifyImage(piture);
  }


//dilog to choose image

 Future<void> _optiondialogbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Take a Picture",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onTap: openCamera,
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  GestureDetector(
                    child: Text(
                      "Select image ",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onTap: openGallery,
                  )
                ],
              ),
            ),
          );
        });
  }


//bottom sheet for results
 void _modalSheetResults(){
        showModalBottomSheet(
            context: context,
            builder: (builder){
              return new Container(
                height: 350.0,
                color: Colors.transparent, //could change this to Color(0xFF737373), 
                           //so you don't have to change MaterialApp canvasColor
                child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: new Center(
                      child: new Text("This is a modal sheet"),
                    )),
              );
            }
        );
      }





  @override
  Widget build(BuildContext context) {


   List<String?> types =[getTranslated('new_arrival', context),
   getTranslated('top_product', context), 
   getTranslated('best_selling', context),  
   getTranslated('discounted_product', context)];
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _loadData(context, true);
            await Provider.of<FlashDealProvider>(context, listen: false).getMegaDealList(true, context, false);

            // return true;
          },
          child:
          
           Stack(
            children: [
              CustomScrollView(
                controller: homeScrollController,
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  // App Bar
                  SliverAppBar(
                    floating: true,
                      //  floating: true,
                pinned: true ,
                    elevation: 0,
                    toolbarHeight: 100,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).highlightColor,
                    title: 
                    
                    isTablet(context)?

Consumer<ProfileProvider>(
            builder: (context, profile, child) {
 return  


 Row(
  mainAxisSize: MainAxisSize.min,
   children: [
     Text(
       getLang(context)=="ar"?
       "مرحبا ،":
       "Hey , " 
       "dfs"
      
     
                        
                        ),
SizedBox(width: 3,)

,
Text(
"${
      
        !isGuestMode ?
     
     
                         profile.userInfoModel != null
                          ?
     
                         profile.userInfoModel!.fName
                          : 
     
                      getLang(context)=="ar"?"رائر":
                         'Guest'
                        
                          : 
                        
                          getLang(context)=="ar"?"رائر":
                         'Guest'
                        
                        
                         }"
)

   ],
 );


//  Text('Hey ,  Guest');
            }
            
            
            ):




                 
                    
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
                        
                        
                         height:isTablet(context)? 180: 100 ,scale: 1.2,))),
                    actions: [
//camera
//  Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: IconButton(
//                           onPressed: () {
//                             _optiondialogbox();
//                             // Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen()
                            
//                             // ));
// ///MODEL

                            
//                           },
//                           icon: 
//                      Icon(   Icons.camera_alt ,                       size:  isTablet(context)?  50:24,
// )
                       
                       
//                         ),
//                       ),
                      
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
                          },
                          icon: 
                     Icon(   Icons.notifications,  
                     size:  isTablet(context)?  50:24,
                     
                     )
                       
                       
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                          },
                          icon: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              Images.cart_arrow_down_image,
                              height:
                              
                               isTablet(context)?  50:
                               Dimensions.ICON_SIZE_DEFAULT,
                              width:  isTablet(context)?  50:Dimensions.ICON_SIZE_DEFAULT,
                              color: ColorResources.getPrimary(context),
                              
                            ),
                            Positioned(top: -4, right: -4,
                              child: Consumer<CartProvider>(builder: (context, cart, child) {
                                return CircleAvatar(radius: isTablet(context)?  15: 7, backgroundColor: ColorResources.RED,
                                  child: Text(cart.cartList.length.toString(),
                                      style: titilliumSemiBold.copyWith(color: ColorResources.WHITE, fontSize:
                                      isTablet(context)? 15:
                                      
                                       Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      )),
                                );
                              }),
                            ),
                          ]),
                        ),
                      ),


                    ],
                  ),

                  // Search Button
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 
                        
                        // SearchScreen()
                        NewSearchPage()
                        )),
                            child: Container(padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.HOME_PAGE_PADDING, vertical: Dimensions.PADDING_SIZE_SMALL),
                              color: ColorResources.getHomeBg(context),
                              alignment: Alignment.center,
                              child: 
                              Container(padding: EdgeInsets.only(
                                left: Dimensions.HOME_PAGE_PADDING, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                top: Dimensions.PADDING_SIZE_EXTRA_SMALL, bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),
                                height:
                             
                                
                                 60, alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                  boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ?
                                  900 : 200]!, spreadRadius: 1, blurRadius: 1)],
                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                                child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [

                                  Text(getTranslated('SEARCH_HINT', context)!,
                                      style: robotoRegular.
                                      copyWith(color: Theme.of(context).hintColor,  
                                     fontSize: isTablet(context)?30:20 
                                      
                                      )),

                                  Container(
                                    width:   isTablet(context)?60: 40,height: isTablet(context)?60:40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
                                  ),
                                    child: Icon(Icons.search, color:Colors.black
                                    
                                    //  Theme.of(context).cardColor
                                    
                                    , size: Dimensions.ICON_SIZE_SMALL),
                                  ),
                            ]),
                          ),
                        ),
                      ))),

                  SliverToBoxAdapter(
                    
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(Dimensions.HOME_PAGE_PADDING,
                          Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL  ),
                      child: Column(
                        children: [

                       
//if cusomer is special

Container(
   margin: EdgeInsets.symmetric(
      vertical: 8
    ),
  padding: EdgeInsets.all(15),
  decoration: BoxDecoration(
    border: Border.all(width: 1, )
  ),
  child: Column(children: [
  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [ 
      Container(
        height:isTablet(context)? 80: 60 , width: isTablet(context)? 80: 60 , 
        decoration: BoxDecoration(
          shape: BoxShape.circle , 
          border: Border.all(width: 1)  
        ),
        child: Center(child: Text('Logo'),),
      ), 
      SizedBox(width: 8,) , 
      Expanded(child: Text('مؤسسة خالد بن صالح ابراهيم العويد' ,  overflow: TextOverflow.ellipsis,)),
    ],
  ) , 
   SizedBox(height: 15,) , 
  


  Container(
    height:  35,
   
    decoration: BoxDecoration(
      color: Colors.amber, 
      
    ),
    child: Center(
      child: Text(
        "رصيد حسابكم الإجمالي: 950000 ريال "
      ),
    ),
  ), 
     SizedBox(height: 5,) , 

  Container(
    height:  35,
    decoration: BoxDecoration(
      color: Colors.red, 
      
    ),

     child: Center(
      child: Text(
        "المبلغ المستحق للدفع: 120000 ريال "
      ),
    ),
  ), 
  ],),
), 








                          // Category
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: 
                            TitleRow(
                              
                              isCategory: true,
                              title: getTranslated('CATEGORY', 
                            context),
// showAll: false,
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                 AllCategoryScreen()))),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Padding(
                            padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                            child:
                            
                             CategoryView2(isHomePage: true, 
                            isTablet: isTablet(context),
                            
                            ),
                          ),




   //banner view
                          BannersView(),
                          SizedBox(height: 
                          
                          Dimensions.HOME_PAGE_PADDING),


                          // Mega Deal
                          // Consumer<FlashDealProvider>(
                          //   builder: (context, flashDeal, child) {
                          //     return  (flashDeal.flashDeal != null
                          //         && flashDeal.flashDealList.length > 0)
                          //         ? TitleRow(title: getTranslated('flash_deal', context),
                          //             eventDuration: flashDeal.flashDeal != null ? flashDeal.duration : null,
                          //             onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FlashDealScreen()));
                          //             },isFlash: true,
                          //             )
                          //         : SizedBox.shrink();
                          //   },
                          // ),
                          // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          // Consumer<FlashDealProvider>(
                          //   builder: (context, megaDeal, child) {
                          //     return  (megaDeal.flashDeal != null && megaDeal.flashDealList.length > 0)
                          //         ? Container(height: MediaQuery.of(context).size.width*.77,
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //           child: FlashDealsView(),
                          //         )) : SizedBox.shrink();},),





                          // // Brand
                          // Padding(
                          //   padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          //   bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          //   child: TitleRow(title: getTranslated('brand', context),
                          //       onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => AllBrandScreen()));}),
                          // ),
                          // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          // BrandView(isHomePage: true),



                          //top seller
                          // singleVendor?SizedBox():
                          // TitleRow(title: getTranslated('top_seller', context),
                          //   onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => AllTopSellerScreen(topSeller: null,)));},),
                          // singleVendor?SizedBox(height: 0):SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          // singleVendor?SizedBox():
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //   child: TopSellerView(isHomePage: true),
                          // ),





                          // //footer banner
                          // Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                          //   return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length > 0?
                          //   Padding(
                          //     padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //     child: FooterBannersView(index: 0,),
                          //   ):SizedBox();
                          // }),





                          // // Featured Products
                          // Consumer<ProductProvider>(
                          //   builder: (context, featured,_) {
                          //     return featured.featuredProductList.length>0 ?
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                          //         child: TitleRow(
                          //           title: getTranslated('featured_products', context),
                          //             onTap: () {Navigator.push(context,
                          //              MaterialPageRoute(builder: (_) =>
                          //               AllProductScreen(productType: ProductType.FEATURED_PRODUCT)));}),
                          //       ),
                          //     ):SizedBox();
                          //   }
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //   child: FeaturedProductView(scrollController: _scrollController, isHome: true,),
                          // ),






                          // // Featured Deal
                          // Consumer<FeaturedDealProvider>(
                          //   builder: (context, featuredDealProvider, child) {
                          //     return featuredDealProvider.featuredDealList == null
                          //         ? TitleRow(title: getTranslated('featured_deals', context),
                          //             onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FeaturedDealScreen()));}) :
                          //     (featuredDealProvider.featuredDealList.length > 0) ?
                          //     Padding(
                          //       padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                          //       child: TitleRow(title: getTranslated('featured_deals', context),
                          //           onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FeaturedDealScreen()));}),
                          //     ) : SizedBox.shrink();},),

                          // Consumer<FeaturedDealProvider>(
                          //   builder: (context, featuredDeal, child) {
                          //     return featuredDeal.featuredDealList == null && featuredDeal.featuredDealList.length > 0?
                          //     Container(height: 150, child: FeaturedDealsView()) : (featuredDeal.featuredDealList.length > 0) ?
                          //     Container(height: featuredDeal.featuredDealList.length> 4 ? 120 * 4.0 : 120 * (double.parse(featuredDeal.featuredDealList.length.toString())),
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //           child: FeaturedDealsView(),
                          //         )) : SizedBox.shrink();},),




                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //   child: RecommendedProductView(),
                          // ),





                          // //footer banner
                          // Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                          //   return footerBannerProvider.mainSectionBannerList != null &&
                          //       footerBannerProvider.mainSectionBannerList!.length > 0?
                          //   Padding(
                          //     padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                          //     child: MainSectionBannersView(index: 0,),
                          //   ):SizedBox();

                          // }),

//discount product
SizedBox(height: Dimensions.HOME_PAGE_PADDING),

 Padding(
                            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: TitleRow(title: getTranslated('discounted_product', context),
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => AllBrandScreen())
                                  
                                  
                                  // );
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(
                                    productType: ProductType.DISCOUNTED_PRODUCT)));
                                  }),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

 DiscountProductView(isHomePage: true
                                                    , productType:
                                                     ProductType.DISCOUNTED_PRODUCT, 
                                                     scrollController: 
                                                     homeScrollController),

SizedBox(height: Dimensions.HOME_PAGE_PADDING),


                          // Latest Products
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: TitleRow(title: getTranslated('latest_products', context),
                                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(
                                    productType: ProductType.LATEST_PRODUCT)));}),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          LatestProductView(scrollController: homeScrollController),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),



                          //Home category
                          // HomeCategoryProductView(isHomePage: true),
                          // SizedBox(height: Dimensions.HOME_PAGE_PADDING),



                          //footer banner
                          // Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                          //   return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length>1?
                          //   FooterBannersView(index: 1):SizedBox();
                          // }),
                          // SizedBox(height: Dimensions.HOME_PAGE_PADDING),


                          // //Category filter
                          // Consumer<ProductProvider>(
                          //     builder: (ctx,prodProvider,child) {
                          //   return Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          //     child: Row(children: [
                          //       Expanded(child: Text(prodProvider.title == 'xyz' ?
                          //        getTranslated('new_arrival',context)!:prodProvider.title!, style: titleHeader)),
                                 
                          //       prodProvider.latestProductList != null ? 
                                
                                
                          //       PopupMenuButton(
                          //         itemBuilder: (context) {
                          //           return [
                          //             PopupMenuItem(value: ProductType.NEW_ARRIVAL, child: Text(getTranslated('new_arrival',context)!), textStyle: robotoRegular.copyWith(
                          //               color: Theme.of(context).hintColor,
                          //                )),
                          //             PopupMenuItem(value: ProductType.TOP_PRODUCT, child: Text(getTranslated('top_product',context)!), textStyle: robotoRegular.copyWith(
                          //               color: Theme.of(context).hintColor,
                          //               )),
                          //             PopupMenuItem(value: ProductType.BEST_SELLING, child: Text(getTranslated('best_selling',context)!), textStyle: robotoRegular.copyWith(
                          //               color: Theme.of(context).hintColor,
                          //              )),
                          //             PopupMenuItem(value: ProductType.DISCOUNTED_PRODUCT, 
                          //             child: Text(getTranslated('discounted_product',context)!), textStyle: robotoRegular.copyWith(
                          //               color: Theme.of(context).hintColor,
                          //             )),
                          //           ];
                          //         },
                          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
                          //         child: Padding(
                          //           padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical:Dimensions.PADDING_SIZE_SMALL ),
                          //           child: Image.asset(Images.dropdown, scale: 3,),
                          //         ),
                          //         onSelected: (dynamic value) {
                          //           if(value == ProductType.NEW_ARRIVAL){
                          //             Provider.of<ProductProvider>(context, listen: false)
                          //             .changeTypeOfProduct(value, types[0]);
                          //           }else if(value == ProductType.TOP_PRODUCT){

                          //             Provider.of<ProductProvider>(context, listen: false).
                          //             changeTypeOfProduct(value, types[1]);
                          //           }else if(value == ProductType.BEST_SELLING){
                          //             Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[2]);
                          //           }else if(value == ProductType.DISCOUNTED_PRODUCT){
                          //             Provider.of<ProductProvider>(context, listen: false).
                          //             changeTypeOfProduct(value, types[3]);
                          //           }

                          //           ProductView(isHomePage: false, productType: value,
                          //            scrollController: _scrollController);
                          //                                               // ProductViewSimple(
                          //                                               //   isHomePage: false, productType: value, scrollController: _scrollController);

                          //           Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, context, reload: true);


                          //         }
                          //       ) : SizedBox(),
                          //     ]),
                          //   );
                          // }),
                          // // ProductView(isHomePage: false, productType: ProductType.NEW_ARRIVAL, scrollController: _scrollController),
                          
                          //                           ProductViewSimple(isHomePage: false
                          //                           , productType:
                          //                            ProductType.NEW_ARRIVAL, 
                          //                            scrollController: 
                          //                            _scrollController),




//new arraivals

// Padding(
//                             padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
//                             bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                             child: TitleRow(title: getTranslated('new_arrival', context),
//                                 onTap: () {
//                                   // Navigator.push(context, MaterialPageRoute(builder: (_) => AllBrandScreen())
                                  
//                                   // );
                                  
//                                   }),
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

RecommendedProductView(
  
)


//  NewArrivalsProductView(isHomePage: true
//                                                     , productType:
//                                                      ProductType.NEW_ARRIVAL, 
//                                                      scrollController: 
//                                                      homeScrollController)
                                                     
                                                     
                                                     
                                                     ,


SizedBox(height: Dimensions.HOME_PAGE_PADDING),
 // Brand
                          Padding(
                            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: TitleRow(title: getTranslated('brand', context),
                                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => AllBrandScreen()));}),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          BrandView(isHomePage: true),


                          
                          SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                        ],
                      ),
                    ),
                  )
                
                
                
                ],
              ),

              Provider.of<SplashProvider>(context, listen: false).configModel!.announcement!.status == '1'?
              Positioned(top: MediaQuery.of(context).size.height-128,
                left: 0,right: 0,
                child: Consumer<SplashProvider>(
                  builder: (context, announcement, _){
                    return (announcement.configModel!.announcement!.announcement != null && announcement.onOff)?
                    AnnouncementScreen(announcement: announcement.configModel!.announcement):SizedBox();
                  },

                ),
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
 
 
 
 
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 || oldDelegate.minExtent != 70 || child != oldDelegate.child;
  }
}


class ScrollListener extends ChangeNotifier {
  double bottom = 0;
  double _last = 0;

  ScrollListener.initialise(ScrollController controller, [double height = 56]) {
    controller.addListener(() {
      final current = controller.offset;
      bottom += _last - current;
      if (bottom <= -height) bottom = -height;
      if (bottom >= 0) bottom = 0;
      _last = current;
      if (bottom <= 0 && bottom >= -height) notifyListeners();
    });
  }
}
