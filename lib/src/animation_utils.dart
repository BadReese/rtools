import 'package:flutter/cupertino.dart';

class AnimationUtils {
  static Widget animationPullDown(
      Widget child, Duration duration, TickerProvider vsync) {
    var _animationController =
        AnimationController(duration: duration, vsync: vsync);
    _animationController.forward();
    return SizeTransition(
      axis: Axis.vertical,
      child: child,
      axisAlignment: 1,
      sizeFactor: Tween(begin: 0.0, end: 1.0).animate(_animationController),
    );
  }
}
