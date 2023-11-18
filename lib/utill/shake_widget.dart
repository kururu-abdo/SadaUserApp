import 'package:eamar_user_app/utill/abstract_animation_controller.dart';
import 'package:eamar_user_app/view/screen/jobs/widgets/sin_curve.dart';
import 'package:flutter/material.dart';

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    required this.child,
    required this.shakeOffset,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 500),
  }) : super(key: key);
  // 1. pass a child widget
  final Widget child;
  // 2. configurable properties
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  // 3. pass the shakeDuration as an argument to ShakeWidgetState. See below.
  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}
class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);
  // 1. create a Tween
  late Animation<double> _sineAnimation = Tween(
    begin: 0.0,
    end: 1.0,
    // 2. animate it with a CurvedAnimation
  ).animate(CurvedAnimation(
    parent: animationController,
    // 3. use our SineCurve
    curve: SineCurve(count: widget.shakeCount.toDouble()),
  ));

@override
void initState() {
  super.initState();
  // 1. register a status listener
  animationController.addStatusListener(_updateStatus);
}
// note: this method is public
void shake() {
  animationController.forward();
}

@override
void dispose() {
  // 2. dispose it when done
  animationController.removeStatusListener(_updateStatus);
  super.dispose();
}

void _updateStatus(AnimationStatus status) {
  // 3. reset animationController when the animation is complete
  if (status == AnimationStatus.completed) {
    animationController.reset();
  }
}
  @override
Widget build(BuildContext context) {
  // 1. return an AnimatedBuilder
  return AnimatedBuilder(
    // 2. pass our custom animation as an argument
    animation: _sineAnimation,
    // 3. optimization: pass the given child as an argument
    child: widget.child,
    builder: (context, child) {
      return Transform.translate(
        // 4. apply a translation as a function of the animation value
        offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
        // 5. use the child widget
        child: child,
      );
    },
  );
}
}