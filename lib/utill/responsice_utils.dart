import 'package:flutter/material.dart';

abstract class ResponsiveUtils extends StatelessWidget {
  static const double mobileWidthLimit = 650;
  static const double tabletWidthLimit = 1100;
  final Widget screenWeb;
  final Widget screenTablet;
  final Widget screenMobile;

  const ResponsiveUtils(
      {Key? key,
      required this.screenWeb,
      required this.screenTablet,
      required this.screenMobile})
      : super(key: key);

  static bool isScreenWeb(final BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletWidthLimit;

  static bool isScreenTablet(final BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidthLimit &&
      MediaQuery.of(context).size.width <= tabletWidthLimit;

  static bool isScreenMobile(final BuildContext context) =>
      MediaQuery.of(context).size.width <= mobileWidthLimit;
}