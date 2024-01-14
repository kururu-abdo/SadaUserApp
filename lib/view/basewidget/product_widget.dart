import 'dart:developer';

import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/screen/product/product_details_screen2.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/helper/price_converter.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/rating_bar.dart';
import 'package:eamar_user_app/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Product productModel;
  ProductWidget({required this.productModel});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  @override
  Widget build(BuildContext context) {
    String ratting = widget.productModel.rating != null && widget.productModel.rating!.length != 0? widget.productModel.rating![0].average! : "0";
// return SizedBox();
    return InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails2(product: widget.productModel),
        ));
      },
      child: Container(
        height: 
         isTablet(context)? 
  MediaQuery.of(context).size.width/1.8:
        MediaQuery.of(context).size.width/1.4  ,
      //   width: isTablet(context)? MediaQuery.of(context).size.width/4:
      
      // MediaQuery.of(context).size.width/2
      
      // ,
        // MediaQuery.of(context).size.width/1.5,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              height: MediaQuery.of(context).size.width/2.45,
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder, fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width/2.45,
                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${widget.productModel.thumbnail}',
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_1x1,
                      fit: BoxFit.cover,height: MediaQuery.of(context).size.width/2.45),
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.only(top :Dimensions.PADDING_SIZE_SMALL,bottom: 5, left: 5,right: 5),
              child: Container(

                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width:
                  //  MediaQuery.of(context).size.width.:
                        MediaQuery.of(context).size.width/2 , 
                        
                        // ,
                        child: Text(widget.productModel.name ?? '', textAlign: TextAlign.center,
                            style: robotoRegular.copyWith(fontSize:
                          
                            
                            
                            Dimensions.FONT_SIZE_SMALL,
                            fontWeight: FontWeight.w400), maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar(
                              rating: double.parse(ratting),
                              size: 18,
                            ),


                        Text('(${widget.productModel.reviewCount.toString() })',
                            style: robotoRegular.copyWith(
                              fontSize:
                              
                              
                               Dimensions.FONT_SIZE_SMALL,
                            )),

                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                        widget.productModel.discount!= null && widget.productModel.discount! > 0 ?
                        Text(PriceConverter.convertPrice(context, widget.productModel.unitPrice),
                        style: titleRegular.copyWith(
                          color: ColorResources.getRed(context),
                          decoration: TextDecoration.lineThrough,

                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        ),
                      ) : SizedBox.shrink(),
                      SizedBox(height: 2,),


                      Text(PriceConverter.convertPrice(context,
                          widget.productModel.unitPrice, discountType: widget.productModel.discountType,
                          discount: widget.productModel.discount),
                        style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ]),

          // Off

          widget.productModel.discount! > 0 ?
          Positioned(top: 0, left: 0, child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.getPrimary(context),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),


              child: Center(
                child: Text(PriceConverter.percentageCalculation(context, widget.productModel.unitPrice,
                      widget.productModel.discount, widget.productModel.discountType),
                  style: robotoRegular.copyWith(color: Theme.of(context).highlightColor,
                      fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ),
            ),
          ) : SizedBox.shrink(),

        ]),
      ),
    );
  }
}

