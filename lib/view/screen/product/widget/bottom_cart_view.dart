import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/cart_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/show_custom_snakbar.dart';
import 'package:eamar_user_app/view/screen/cart/cart_screen.dart';
import 'package:eamar_user_app/view/screen/product/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BottomCartView extends StatelessWidget {
  final Product? product;
  BottomCartView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300]!, blurRadius: 15, spreadRadius: 1)],
      ),
      child: Row(children: [
        Expanded(flex: 3, child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Stack(children: [
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CartScreen()
                  ));
                },
                child: Image.asset(Images.cart_arrow_down_image, color: ColorResources.getPrimary(context))),
            Positioned(
              top: 0,
              right: 15,
              child: Consumer<CartProvider>(builder: (context, cart, child) {
                return Container(
                  height: 17,
                  width: 17,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.getPrimary(context),
                  ),
                  child: Text(
                    cart.cartList.length.toString(),
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color:Theme.of(context).highlightColor),
                  ),
                );
              }),
            )
          ]),
        )),
    
        Expanded(flex: 11, child: InkWell(
          onTap: () {
            showModalBottomSheet(context: context, 
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width 
            ),
            
            isScrollControlled: true,
             backgroundColor: Colors.transparent, builder: (con) =>
              CartBottomSheet(product: product, callback: (){
              showCustomSnackBar(getTranslated('added_to_cart', context)!, context, isError: false);
            },));
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.getPrimary(context),
            ),
            child: Text(
              getTranslated('add_to_cart', context)!,
              style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).highlightColor),
            ),
          ),
        )),
      ]),
    );
  }
}
