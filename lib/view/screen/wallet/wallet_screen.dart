
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/helper/price_converter.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/provider/wallet_transaction_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/custom_app_bar.dart';
import 'package:eamar_user_app/view/basewidget/not_loggedin_widget.dart';
import 'package:eamar_user_app/view/screen/wallet/widget/transaction_list_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class WalletScreen extends StatelessWidget {
  final bool isBacButtonExist;
  WalletScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context, listen: false).darkTheme;
    bool isFirstTime = true;
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(isFirstTime) {
      if(!isGuestMode) {
        Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
        Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context,1);
      }

      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('wallet', context), isBackButtonExist: isBacButtonExist),
          isGuestMode ? SizedBox() :
          Column(
            children: [
              Consumer<WalletTransactionProvider>(
                builder: (context, profile,_) {
                  return Container(
                    height: MediaQuery.of(context).size.width/2.5,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      boxShadow: [BoxShadow(color: Colors.grey[darkMode ? 900 : 200]!,
                          spreadRadius: 0.5, blurRadius: 0.3)],
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container (
                                width: Dimensions.LOGO_HEIGHT,
                                height: Dimensions.LOGO_HEIGHT,
                                child: Image.asset(Images.wallet)),
                            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(getTranslated('wallet_amount', context)!, style: TextStyle(fontWeight: FontWeight.w400,
                                    color: Colors.white,fontSize: Dimensions.FONT_SIZE_LARGE)),

                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                Text(PriceConverter.convertPrice(context, (profile.walletBalance != null && profile.walletBalance!.totalWalletBalance != null) ?
                                profile.walletBalance!.totalWalletBalance ?? 0 : 0),
                                    style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white,
                                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE)),
                              ],
                            ),
                            SizedBox(width: Dimensions.LOGO_HEIGHT,),
                          ],
                        ),


                      ],
                    ),
                  );
                }
              ),

              TransactionListView()
            ],
          ),


          isGuestMode ? Expanded(child: NotLoggedInWidget()) :
          SizedBox(),
        ],
      ),
    );
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


