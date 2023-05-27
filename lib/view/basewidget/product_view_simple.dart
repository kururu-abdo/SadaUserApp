import 'dart:developer';

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

class ProductWidgetSimple extends StatefulWidget {
  final Product productModel;
  ProductWidgetSimple({required this.productModel});

  @override
  State<ProductWidgetSimple> createState() => _ProductWidgetSimpleState();
}

class _ProductWidgetSimpleState extends State<ProductWidgetSimple> {

  @override
  Widget build(BuildContext context) {
    String ratting = widget.productModel.rating != null && widget.productModel.rating!.length != 0? widget.productModel.rating![0].average! : "0";
var direction=Directionality.of(context);


return 
 InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails2(product: widget.productModel),
        ));
      },
  child:   Container(
          height: 
          MediaQuery.of(context).size.height/6  ,
          
          // MediaQuery.of(context).size.width/1.5,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
          ),
  
          child: Row(children: [
  
  ClipRRect(
     borderRadius: BorderRadius.circular(10),
    child:   Container(
        height: MediaQuery.of(context).size.height/6,
                        width:    (MediaQuery.of(context).size.width)/4,
      child:   Stack(
        children: [
          FadeInImage.assetNetwork(
                            placeholder: Images.placeholder, 
                            fit: BoxFit.cover,
                            width:    (MediaQuery.of(context).size.width)/4,
                                // height: MediaQuery.of(context).size.width/2.45
                                 height: MediaQuery.of(context).size.height/6,
                            image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${widget.productModel.thumbnail}',
                            imageErrorBuilder: (c, o, s) =>
                             Image.asset(Images.placeholder_1x1,
                                fit: BoxFit.cover,
                                     width:    (MediaQuery.of(context).size.width)/4,
                                // height: MediaQuery.of(context).size.width/2.45
                                 height: MediaQuery.of(context).size.height/6,
                                ),
                          ),
      widget.productModel.discount! > 0 ?
            Align
            (
            //   top: 0, 
            
           alignment: AlignmentDirectional.topStart
            // left: 0,
            
            // rect: RelativeRect.(textDirection: direction,
            //  start: 0, 
            //  end: 0,bottom: 20 ,
            //  top: 0,  )
            , child: Container(
                height: 20,
                width: (  (MediaQuery.of(context).size.width)/4)*2/3 ,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                decoration: BoxDecoration(
                  color: ColorResources.getPrimary(context),
                  borderRadius: BorderRadius.only(topLeft: direction==TextDirection.ltr?

                  Radius.circular(10):Radius.circular(0),
                  
                   bottomRight: 
                   direction==TextDirection.ltr?
                   
                   Radius.circular(10):Radius.circular(0),
                   
                   topRight: direction==TextDirection.rtl?

                  Radius.circular(10):Radius.circular(0),
                  
                   bottomLeft: 
                   direction==TextDirection.rtl?
                   
                   Radius.circular(10):Radius.circular(0),
                   
                   ),
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
                          
        ],
      ),
    ),
  ),
  
       Padding(
                padding: EdgeInsets.only(top :Dimensions.PADDING_SIZE_SMALL,bottom: 5, left: 5,right: 5),
                child: Container(
  
                  child: Center(
                    child: 
                    
                    Column(
  
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width)*2/5,
                          child: Text(widget.productModel.name ?? '', textAlign: TextAlign.justify,
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                              fontWeight: FontWeight.w400), maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
  
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBarOneStar(
                                rating: double.parse(ratting),
                                size: 18,
                              ),
  
  
                          Text('(${widget.productModel.reviewCount.toString() })',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                              )),
  
                        ]),
                        // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
  
  
  
                      ],
                    ),
                  
                  
                  ),
                ),
              ),
  
  Spacer(),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
              
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
                 
  
                 
  
  
        //          InkWell(
        //            onTap: (){
  
        //               Navigator.push(context, PageRouteBuilder(
        //   transitionDuration: Duration(milliseconds: 1000),
        //   pageBuilder: (context, anim1, anim2) => ProductDetails(product: widget.productModel),
        // ));
        //            },
        //            child: Container(
        //              margin: const EdgeInsets.all(5.0),
        //              width: 30,
        //              height: 30,
        //              decoration: BoxDecoration(
        //                color: Theme.of(context).primaryColor
                 
        //                ,borderRadius: BorderRadius.circular(5)
        //              ),
                 
        //              child: Center(
        //                child: Icon(Icons.add ,
        //                size: 20,color: 
                       
        //                Theme.of(context).colorScheme.onPrimary,
        //                ),
        //              ),
        //            ),
        //          )
                 
                 
                  ],
                ),
              )
  
  
          ]),
  
           ),
);
    return InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(product: widget.productModel),
        ));
      },
      child: Container(
        height: 
        MediaQuery.of(context).size.width/1.5  ,
        
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
                  child: 
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.productModel.name ?? '', textAlign: TextAlign.center,
                          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                          fontWeight: FontWeight.w400), maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar(
                              rating: double.parse(ratting),
                              size: 18,
                            ),


                        Text('(${widget.productModel.reviewCount.toString()})',
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
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

