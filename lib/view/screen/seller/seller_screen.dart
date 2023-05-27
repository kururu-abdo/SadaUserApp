import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/seller_model.dart';

import 'package:eamar_user_app/helper/product_type.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/animated_custom_dialog.dart';
import 'package:eamar_user_app/view/basewidget/custom_app_bar.dart';
import 'package:eamar_user_app/view/basewidget/guest_dialog.dart';
import 'package:eamar_user_app/view/basewidget/rating_bar.dart';
import 'package:eamar_user_app/view/basewidget/search_widget.dart';
import 'package:eamar_user_app/view/screen/chat/chat_screen.dart';
import 'package:eamar_user_app/view/screen/home/widget/products_view.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class SellerScreen extends StatefulWidget {
  final SellerModel? seller;
  SellerScreen({required this.seller});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  ScrollController _scrollController = ScrollController();

  void _load(){
    Provider.of<ProductProvider>(context, listen: false).removeFirstLoading();
    Provider.of<ProductProvider>(context, listen: false).clearSellerData();
    Provider.of<ProductProvider>(context, listen: false).initSellerProductList(widget.seller!.seller!.id.toString(), 1, context);
  }


  @override
  void initState() {
    super.initState();
    _load();
  }




  @override
  Widget build(BuildContext context) {


    String ratting = widget.seller != null && widget.seller!.avgRating != null? widget.seller!.avgRating.toString() : "0";



    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),

      body: Column(
        children: [
          CustomAppBar(title: '${widget.seller!.seller!.fName}'+' ''${widget.seller!.seller!.lName}'),

          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: [

                // Banner
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, height: 120, fit: BoxFit.cover,
                      image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl}/banner/${widget.seller!.seller!.shop != null ? widget.seller!.seller!.shop!.banner : ''}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 120, fit: BoxFit.cover),
                    ),
                  ),
                ),

                Container(
                  color: Theme.of(context).highlightColor,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [

                    // Seller Info
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder, height: 80, width: 80, fit: BoxFit.cover,
                          image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl}/${widget.seller!.seller!.shop!.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 80, width: 80, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.seller!.seller!.shop!.name!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE), maxLines: 1, overflow: TextOverflow.ellipsis,),

                            Row(
                              children: [
                                RatingBar(rating: double.parse(ratting)),
                                
                                Text('(${widget.seller!.totalReview.toString()})' , style: titilliumRegular.copyWith(), maxLines: 1, overflow: TextOverflow.ellipsis,),

                              ],
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            Row(
                              children: [
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
                                  child: Text(widget.seller!.totalReview.toString() +' '+ '${getTranslated('reviews', context)}',
                                    style: titleRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                        color: ColorResources.getReviewRattingColor(context)),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,),
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                                Text('|'),
                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                                Text(widget.seller!.totalProduct.toString() +' '+
                                    '${getTranslated('products', context)}',
                                  style: titleRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: ColorResources.getReviewRattingColor(context)),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ],
                            ),


                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if(!Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                            showAnimatedDialog(context, GuestDialog(), isFlip: true);
                          }else if(widget.seller != null) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(seller: widget.seller)));
                          }
                        },
                        icon: Image.asset(Images.chat_image, color: ColorResources.SELLER_TXT, height: Dimensions.ICON_SIZE_DEFAULT),
                      ),
                    ]),

                  ]),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                  child: SearchWidget(
                    hintText: 'Search product...',
                    onTextChanged: (String newText) => Provider.of<ProductProvider>(context, listen: false).filterData(newText),
                    onClearPressed: () {},
                    isSeller: true,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  child: ProductView(isHomePage: false,
                   productType: ProductType.SELLER_PRODUCT, scrollController:
                   _scrollController, sellerId: 
                   widget.seller!.seller!.id.toString()),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
