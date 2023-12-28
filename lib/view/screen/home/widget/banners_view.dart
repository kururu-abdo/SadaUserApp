import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/screen/product/product_details_screen2.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/provider/banner_provider.dart';
import 'package:eamar_user_app/provider/brand_provider.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/top_seller_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:eamar_user_app/view/screen/product/product_details_screen.dart';
import 'package:eamar_user_app/view/screen/topSeller/top_seller_product_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
class BannersView extends StatelessWidget {
Future<void> _lauchUrl(String url) async {
   try {
      final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri);
   } catch (e) {
   }
  }
  _clickBannerRedirect(BuildContext context, int? id, 
  Product? product,  String? type){


log(type.toString());
    if(type == 'category'){
          final cIndex =  Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);

      if(Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name != null){
       
      
       
       
        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          isBrand: false,
          id: id.toString(),
          name: '${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}',
        )));
      }

    }else if(type == 'product'){

         
      
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails2(
        product: product!,
      )));

    }else if(type == 'brand'){
          final bIndex =  Provider.of<BrandProvider>(context, listen: false).brandList.indexWhere((element) => element.id == id);

      if(Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          isBrand: true,
          id: id.toString(),
          name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',
        )));
    }

    }else if( type == 'shop'){
          final tIndex =  Provider.of<TopSellerProvider>(context, listen: false).topSellerList.indexWhere((element) => element.id == id);

      if(Provider.of<TopSellerProvider>(context, listen: false).topSellerList[tIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
          topSellerId: id,
          topSeller: Provider.of<TopSellerProvider>(context,listen: false).topSellerList[tIndex],
        )));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, bannerProvider, child) {

            double _width = MediaQuery.of(context).size.width;
                        double _height = MediaQuery.of(context).size.height;

            return Container(
              width: _width,
              height:
              isTablet(context)?
                _width * 0.3:
              
               _width * 0.4,
              child: bannerProvider.mainBannerList != null ? bannerProvider.mainBannerList!.length != 0 ? Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      onPageChanged: (index, reason) {
                         log("ON TAP BANNER"+index.toString());
                        Provider.of<BannerProvider>(context, listen: false).setCurrentIndex(index);
                      },
                    ),
                    itemCount:
                     bannerProvider.mainBannerList!.length == 0 ? 1 :
                      bannerProvider.mainBannerList!.length,
                    itemBuilder: (context, index, _) {

                      return GestureDetector(
                        onTap: () {
                          
                          debugPrint("ON TAP BANNER"+bannerProvider.mainBannerList![index].resourceType.toString()
                          +"\n"+
                         ( bannerProvider.mainBannerList![index].product==null).toString()


                         +"\n"+ 

                         "BANNER TYPE"+   bannerProvider.mainBannerList![index].bannerType.toString()
                          .toString());
                          


if(
  bannerProvider.mainBannerList![index].resourceType.toString()=="product"&&
  
  ( bannerProvider.mainBannerList![index].product==null)){
    //launch url 
_lauchUrl( bannerProvider.mainBannerList![index].url!);

}else {





                          _clickBannerRedirect(context,
                              bannerProvider.mainBannerList![index].resourceId,



                              bannerProvider.mainBannerList![index].resourceType 
                              
                              
                              =='product'?
                              bannerProvider.mainBannerList![index].product : null
                              
                              
                              ,
                              bannerProvider.mainBannerList![index].resourceType);
                        
                        
                        
}


                        
                        },
                        child:
                        
                        
                         Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder, fit: BoxFit.cover,
                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.bannerImageUrl}'
                                  '/${bannerProvider.mainBannerList![index].photo}',
                              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_3x1, fit: BoxFit.cover),
                            ),
                          ),
                        ),




                      );
                    },
                  ),

                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bannerProvider.mainBannerList!.map((banner) {
                        int index = bannerProvider.mainBannerList!.indexOf(banner);
                        return TabPageSelectorIndicator(
                          backgroundColor: index == bannerProvider.currentIndex ? Theme.of(context).primaryColor : Colors.grey,
                          borderColor: index == bannerProvider.currentIndex ? Theme.of(context).primaryColor : Colors.grey,
                          size: 10,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ) : Center(child: Text('No banner available')) : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: bannerProvider.mainBannerList == null,
                child: Container(margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.WHITE,
                )),
              ),
            );
          },
        ),

        SizedBox(height: 5),
      ],
    );
  }


}

