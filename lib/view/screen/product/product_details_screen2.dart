
import 'dart:io';

import 'package:eamar_user_app/data/datasource/remote/chache/app_path_provider.dart';
import 'package:eamar_user_app/view/screen/product/widget/product_image_view2.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
import 'package:rating_dialog/rating_dialog.dart';

import 'faq_and_review_screen.dart';



class ProductDetails2 extends StatefulWidget {
  final Product? product;

  final String? id;
  final String? slug;
    final String? seller;

  ProductDetails2({required this.product, this.id ,this.slug  , this.seller});



  @override
  State<ProductDetails2> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails2> {







  _loadData( BuildContext context) async{

    if (     widget.product!=null) {
   final product = AnalyticsEventItem(
    itemId: "${widget.product!.slug}",
    itemName: "${widget.product!.name}",
    itemCategory: "${widget.product!.categoryIds!.first}",
    itemVariant: "${widget.product!.colors!.length>0?widget.product!.colors!.first:''}",
    price: widget.product!.unitPrice,

);



await FirebaseAnalytics.instance.logSelectItem(
    itemListId: "${widget.product!.slug}",
    itemListName: "Common products",
    items: [product],
);
    }
      Provider.of<ProductDetailsProvider>(context, listen: false).removePrevReview();

      Provider.of<ProductDetailsProvider>(context, listen: false).initProduct(
        widget.product==null?
       null:
        widget.product,

     

       context);
      Provider.of<ProductProvider>(context, listen: false).removePrevRelatedProduct();
      Provider.of<ProductProvider>(context, listen: false).initRelatedProductList( widget.product==null?
          widget.id!:
          widget.product!.id.toString(), context);
      Provider.of<ProductDetailsProvider>(context, listen: false).getCount( widget.product==null?
          widget.id!:
          widget.product!.id.toString(), context);
      Provider.of<ProductDetailsProvider>(context, listen: false).getSharableLink(
        widget.product==null?
          widget.slug!:
          widget.product!.slug.toString(), context);
      if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      
        Provider.of<WishListProvider>(context, listen: false).checkWishList(
          widget.product==null?
          widget.id:
          widget.product!.id.toString(), context);
      }
      Provider.of<ProductProvider>(context, listen: false).initSellerProductList(
        
             widget.product!=null?
        
        widget.product!.userId.toString():widget.seller!, 1, context);



  }

  @override
  Widget build(BuildContext context) {
  ScrollController _scrollController = ScrollController();
    String ratting = widget.product != null &&
      widget.product!.rating != null &&
     widget.product!.rating!.length != 0?
    widget.product!.rating![0].average.toString() : "0";
    _loadData(context);




   return widget.product != null?

      Consumer<ProductDetailsProvider>(
      builder: (context, details, child) {

        return details.hasConnection ?
Scaffold(

  backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor, size: 20),
                onTap: () => Navigator.pop(context),),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


              Text(getTranslated('product_details', context)!,

              
                  style: robotoRegular.copyWith(fontSize: 20,
                      color: Theme.of(context).cardColor)
                      
                      
                      ),
            ]),

            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,
          ),

      bottomNavigationBar: BottomCartView(product: widget.product),








          body: 
          
          
          
          
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [

//image view 

     widget.product != null?

 ProductImageView2(productModel: widget.product!)
     :
     SizedBox(),



//details

  Container(
padding: EdgeInsets.only(top: Dimensions.FONT_SIZE_DEFAULT),

                     decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    
                        ),


      child: Column(children: [

                    ProductTitleView(productModel: widget.product),



                    (widget.product!.details != null && widget.product!.details!.isNotEmpty) ?
                    Container(height: 250,
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: 
                      ProductSpecification(productSpecification: widget.product!.details
                       ?? ''),) : SizedBox(),

                    widget.product!.videoUrl != null?
                    YoutubeVideoWidget(url: widget.product!.videoUrl):SizedBox(),

                    Container(padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        horizontal: Dimensions.FONT_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor
                        ),
                        child: PromiseScreen()),



                    widget.product!.addedBy == 'seller' ? 
                    SellerView(sellerId: widget.product!.userId.toString()) :
                     SizedBox.shrink(),



                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      color: Theme.of(context).cardColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [


                        Text(getTranslated('customer_reviews', context)!,
                          style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                        Container(width: 230,height: 30,
                          decoration: BoxDecoration(color: ColorResources.visitShop(context),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),),


                          child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar(rating: double.parse(ratting), size: 18,),
                            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                            Text('${double.parse(ratting).toStringAsFixed(1)}'+ ' '+ '${getTranslated('out_of_5', context)}'),
                          ],
                        ),
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Text('${getTranslated('total', context)}' + ' '+'${details.reviewList != null ? details.reviewList!.length : 0}' +' '+ '${getTranslated('reviews', context)}'),



                      details.reviewList != null ? details.reviewList!.length != 0 ?
                       GestureDetector(
                         
                         
                         onTap: ()async{



                            final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'What is your rate',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Please share your opinion about us',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      // image: const FlutterLogo(size: 100),
      submitButtonText: 'Add Rating',
      commentHint: 'let see you opinion',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
//

//call api to send rate



        // TODO: add your own logic
        // if (response.rating < 3.0) {
        //   // send their comments to your email or anywhere you wish
        //   // ask the user to contact you instead of leaving a bad review
        // } else {
        //   // _rateAndReviewApp();
        // }
      },
    );

  showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );


                         },
                         
                         
                         child: ReviewWidget(reviewModel: details.reviewList![0]))

                          : SizedBox() : ReviewShimmer(),

                      details.reviewList != null ? details.reviewList!.length > 1 ?
                       GestureDetector(
                               
                         onTap: ()async{



                    


                         },
                         
                         
                         child: ReviewWidget(reviewModel: details.reviewList![1]))


                          : SizedBox() : ReviewShimmer(),
                      details.reviewList != null ? details.reviewList!.length > 2 ? 
                      
                      GestureDetector(
                        
                              
                         onTap: ()async{



                            final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'What is your rate',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Please share your opinion about us',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      // image: const FlutterLogo(size: 100),
      submitButtonText: 'Add Rating',
      commentHint: 'let see you opinion',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
//

//call api to send rate



        // TODO: add your own logic
        // if (response.rating < 3.0) {
        //   // send their comments to your email or anywhere you wish
        //   // ask the user to contact you instead of leaving a bad review
        // } else {
        //   // _rateAndReviewApp();
        // }
      },
    );

  showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );


                         },
                        
                        
                        child: ReviewWidget(reviewModel: details.reviewList![2]))
                          : SizedBox() : ReviewShimmer(),

                      InkWell(
                          onTap: () {
                            if(details.reviewList != null)
                            {Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                ReviewScreen(reviewList: details.reviewList)));}},
                          child: 
                          details.reviewList != null && details.reviewList!.length > 3?


                          Text(getTranslated('view_more', context)!,
                            style: 
                            titilliumRegular.copyWith(color: Theme.of(context).primaryColor),)
                            
                            :SizedBox()
                            
                            )



                    ]),
                  ),

                    widget.product!.addedBy == 'seller' ?
                    Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: TitleRow(title: getTranslated('more_from_the_shop', context), isDetailsPage: true),
                    ):SizedBox(),

                    widget.product!.addedBy == 'seller' ?
                    Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: ProductView(isHomePage: true, productType: ProductType.SELLER_PRODUCT,
                          scrollController: _scrollController, sellerId: widget.product!.userId.toString()),):SizedBox(),




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

      ])

  )





              ])
              
              
              )





): 

   Scaffold(body: NoInternetOrDataScreen(isNoInternet: true,
            child: ProductDetails2(product: widget.product)
            
            ))
            
            ;
      })






:SizedBox();


  }




}

