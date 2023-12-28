import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
//here I just use small and large screens .
  final Widget? largeScreen;

  // final Widget mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({Key? key, @required this.largeScreen, this.smallScreen}) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <800;
  }
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 700 && MediaQuery.of(context).size.width < 1000;
  }
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >=800;
  }
 

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return largeScreen!;
        } else
          return smallScreen!;
      },
    );
  }
}