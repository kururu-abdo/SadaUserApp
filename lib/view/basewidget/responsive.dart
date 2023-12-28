import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({required this.mobile, required this.tablet, required this.desktop, super.key});

  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600.0;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100.0 && MediaQuery.of(context).size.width >= 600.0;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100.0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => isDesktop(context)
            ? desktop!
            : isTablet(context)
                ? tablet!
                : mobile!,
      );
}