
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
   {  this.text,
     this.gradient,
    // this.style,
  });

  final Widget? text;
  // final TextStyle? style;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      // blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient!.createShader(
        Rect.fromLTWH(0, 0, bounds.width/2, bounds.height),
      ),
      child: text,
    );
  }
}