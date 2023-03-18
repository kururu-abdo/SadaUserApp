import 'dart:io';

import 'package:eamar_user_app/data/datasource/remote/chache/app_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/helper/product_type.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/view/basewidget/rating_bar.dart';
import 'package:eamar_user_app/view/screen/home/widget/products_view.dart';
import 'package:eamar_user_app/view/screen/product/widget/promise_screen.dart';
import 'package:eamar_user_app/view/screen/product/widget/seller_view.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';

import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/product_details_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/provider/wishlist_provider.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/basewidget/title_row.dart';
import 'package:eamar_user_app/view/screen/product/widget/bottom_cart_view.dart';
import 'package:eamar_user_app/view/screen/product/widget/product_image_view.dart';
import 'package:eamar_user_app/view/screen/product/widget/product_specification_view.dart';
import 'package:eamar_user_app/view/screen/product/widget/product_title_view.dart';
import 'package:eamar_user_app/view/screen/product/widget/related_product_view.dart';
import 'package:eamar_user_app/view/screen/product/widget/review_widget.dart';
import 'package:eamar_user_app/view/screen/product/widget/youtube_video_widget.dart';
import 'package:provider/provider.dart';

import 'faq_and_review_screen.dart';

class ProductDetailsFromUrl extends StatefulWidget {

  final String slug;
    

  ProductDetailsFromUrl({ this.slug  ,});



  @override
  State<ProductDetailsFromUrl> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsFromUrl> {
  _loadData( BuildContext context) async{
      Provider.of<ProductDetailsProvider>(context, listen: false).removePrevReview();
      Provider.of<ProductDetailsProvider>(context, listen: false).initProductFromSlug(
       widget.slug,

       context);
  


  }
@override
void initState() { 
  super.initState();
  Future.microtask(()async {
await
    _loadData(context);
  });
}
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    // String ratting = Provider.of<ProductDetailsProvider>(context).myProdutt != null &&
    //   Provider.of<ProductDetailsProvider>(context).myProdutt.rating != null &&
    //  Provider.of<ProductDetailsProvider>(context).myProdutt.rating.length != 0?
    // Provider.of<ProductDetailsProvider>(context).myProdutt.rating[0].average.toString() : "0";
  
  
    



    return   !Provider.of<ProductDetailsProvider>(context).slugLoading?
    Consumer<ProductDetailsProvider>(
      builder: (context, details, child) {

        return details.hasConnection
        
         ?
        
         Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor, size: 20),
                onTap: () => Navigator.pop(context),),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


              Text(getTranslated('product_details', context),
                  style: robotoRegular.copyWith(fontSize: 20,
                      color: Theme.of(context).cardColor)),
            ]),

            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,
          ),



          bottomNavigationBar: BottomCartView(product:  Provider.of<ProductDetailsProvider>(context).myProdutt),



          body:
          
          
           SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Provider.of<ProductDetailsProvider>(context).myProdutt != null?

                ProductImageView(productModel:
                 Provider.of<ProductDetailsProvider>(context).myProdutt):
                 SizedBox(),

                Container(
                  transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                  padding: EdgeInsets.only(top: Dimensions.FONT_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                          topRight:Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE) ),
                        ),
                  child: Column(children: [


                    ProductTitleView(productModel: Provider.of<ProductDetailsProvider>(context).myProdutt),



                    Provider.of<ProductDetailsProvider>(context).myProdutt != null  ?

(Provider.of<ProductDetailsProvider>(context).myProdutt.details != null &&
                     Provider.of<ProductDetailsProvider>(context).myProdutt.details.isNotEmpty) ?
                    Container(height: 250,
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: ProductSpecification(productSpecification: Provider.of<ProductDetailsProvider>(context).myProdutt.details ?? ''),) 
                      :SizedBox()
                      : SizedBox(),

                    Provider.of<ProductDetailsProvider>(context).myProdutt!=null?
                    
                       Provider.of<ProductDetailsProvider>(context).myProdutt.videoUrl != null?

                    YoutubeVideoWidget(url: Provider.of<ProductDetailsProvider>(context).myProdutt.videoUrl):
                     SizedBox():
                    SizedBox(),

                    Container(padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        horizontal: Dimensions.FONT_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor
                        ),
                        child: PromiseScreen())
                        
                        
                        ,

    Provider.of<ProductDetailsProvider>(context).myProdutt!=null?

                    Provider.of<ProductDetailsProvider>(context).myProdutt.addedBy == 'seller' ?


                    
                     SellerView(sellerId:
                      Provider.of<ProductDetailsProvider>(context).myProdutt.userId.toString()) :
                       SizedBox.shrink():
                       SizedBox.shrink(),



                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      color: Theme.of(context).cardColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Text(getTranslated('customer_reviews', context),
                          style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                        Container(width: 230,height: 30,
                          decoration: BoxDecoration(color: ColorResources.visitShop(context),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),),


                          child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar(rating: double.parse(Provider.of<ProductDetailsProvider>(context).ratingValue.toString()), size: 18,),
                            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                            Text('${double.parse(Provider.of<ProductDetailsProvider>(context).ratingValue.toString()).toStringAsFixed(1)}'+ ' '+ '${getTranslated('out_of_5', context)}'),
                          ],
                        ),
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Text('${getTranslated('total', context)}' + ' '+'${details.reviewList != null ? details.reviewList.length : 0}' +' '+ '${getTranslated('reviews', context)}'),



                      details.reviewList != null ?
                       details.reviewList.length != 0 ? 
                       ReviewWidget(reviewModel: details.reviewList[0])
                          : SizedBox() : 

                          ReviewShimmer(),
                      details.reviewList != null ? details.reviewList.length > 1 ? ReviewWidget(reviewModel: details.reviewList[1])
                          : SizedBox() : ReviewShimmer(),
                      details.reviewList != null ? details.reviewList.length > 2 ? ReviewWidget(reviewModel: details.reviewList[2])
                          : SizedBox() : ReviewShimmer(),

                      InkWell(
                          onTap: () {
                            if(details.reviewList != null)
                            {Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                ReviewScreen(reviewList: details.reviewList)));}},
                          child: details.reviewList != null && details.reviewList.length > 3?
                          Text(getTranslated('view_more', context),
                            style: titilliumRegular.copyWith(color: Theme.of(context).primaryColor),):SizedBox())



                    ]),
                  ),
Provider.of<ProductDetailsProvider>(context).myProdutt!=null?
                    Provider.of<ProductDetailsProvider>(context).myProdutt.addedBy == 'seller' ?
                    Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: TitleRow(title: getTranslated('more_from_the_shop', context), isDetailsPage: true),
                    )
                    :SizedBox()
                    :SizedBox()
                    
                    ,
Provider.of<ProductDetailsProvider>(context).myProdutt!=null?
                    Provider.of<ProductDetailsProvider>(context).myProdutt.addedBy == 'seller' ?
                    Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      child: ProductView(isHomePage: true, productType: ProductType.SELLER_PRODUCT,


                          scrollController: _scrollController, sellerId: 
                          Provider.of<ProductDetailsProvider>(context).myProdutt.userId.toString())
                          ,):SizedBox():SizedBox(),




                    Container(
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: TitleRow(title: getTranslated('related_products', context), isDetailsPage: true),
                        ),
                        SizedBox(height: 5),
                        RelatedProductView(),
                      ],
                    ),
                  ),


                ],),),
              ],
            ),
          ),
        ) : 
        
        Scaffold(
          
          body: NoInternetOrDataScreen(isNoInternet: true,
            child: ProductDetailsFromUrl(slug: widget.slug)));
      },
    ):
    
    Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }






}

