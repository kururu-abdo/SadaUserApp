import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final isBackButtonExist;
  final IconData icon;
  final Function onActionPressed;
  final Function onBackPressed;

  CustomAppBar({@required this.title, this.isBackButtonExist = true, this.icon, this.onActionPressed, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(
          Images.toolbar_background, fit: BoxFit.fill,
          height: 50+MediaQuery.of(context).padding.top, width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Colors.white,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [

          isBackButtonExist ? IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20,
                color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
            onPressed: () => onBackPressed != null ? onBackPressed() : Navigator.of(context).pop(),
          ) : SizedBox.shrink(),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

          Expanded(
            child: Text(
              title, style: titilliumRegular.copyWith(fontSize: 20,
              color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ),

          icon != null ? IconButton(
            icon: Icon(icon, size: Dimensions.ICON_SIZE_LARGE, color: Colors.white),
            onPressed: onActionPressed,
          ) : SizedBox.shrink(),

        ]),
      ),
    ]);
  }
}
