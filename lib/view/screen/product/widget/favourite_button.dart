import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/wishlist_provider.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/animated_custom_dialog.dart';
import 'package:eamar_user_app/view/basewidget/guest_dialog.dart';
import 'package:eamar_user_app/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final int? productId;
  FavouriteButton({this.backgroundColor = Colors.black, this.favColor = Colors.white, this.isSelected = false, this.productId});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context, isError: false);
      }
    }

    return GestureDetector(
      onTap: () {
        if (isGuestMode) {
          showAnimatedDialog(context, GuestDialog(), isFlip: true);
        } else {
          Provider.of<WishListProvider>(context, listen: false).isWish ?
          Provider.of<WishListProvider>(context, listen: false).removeWishList(productId, feedbackMessage: feedbackMessage) :
          Provider.of<WishListProvider>(context, listen: false).addWishList(productId, feedbackMessage: feedbackMessage);
        }
      },
      child: Consumer<WishListProvider>(
        builder: (context, wishListProvider, child) => Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: Theme.of(context).cardColor,
          child: Padding(padding: EdgeInsets.all(8),
            child: Image.asset(
              wishListProvider.isWish ? Images.wish_image : Images.wishlist,
              color: favColor, height: 16, width: 16,
            ),
          ),
        ),
      ),
    );
  }
}





class FavouriteButton2 extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final int? productId;
  FavouriteButton2({this.backgroundColor = Colors.black, this.favColor = Colors.white, this.isSelected = false, this.productId});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context, isError: false);
      }
    }

    return GestureDetector(
      onTap: () {
        if (isGuestMode) {
          showAnimatedDialog(context, GuestDialog(), isFlip: true);
        } else {
          Provider.of<WishListProvider>(context, listen: false).isWish ?
          Provider.of<WishListProvider>(context, listen: false).removeWishList(productId, feedbackMessage: feedbackMessage) :
          Provider.of<WishListProvider>(context, listen: false).addWishList(productId, feedbackMessage: feedbackMessage);
        }
      },
      child: Consumer<WishListProvider>(
        builder: (context, wishListProvider, child) => Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: Theme.of(context).cardColor,
          child: Container(  width: 50, height: 50,
            child: Padding(padding: EdgeInsets.all(8),
              child: Image.asset(
                wishListProvider.isWish ? Images.wish_image : Images.wishlist,
                color: favColor, height: 16, width: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
