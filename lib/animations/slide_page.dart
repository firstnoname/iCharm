import 'package:flutter/material.dart';
import 'package:i_charm/utilities/constants.dart';

class SlidePage extends StatelessWidget {
  final Widget child;

  const SlidePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: slideAnimationDuration,
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      child: child,
      transitionBuilder: (child, animation) {
        var offsetAnimation = Tween<Offset>(
          begin: Offset(0.0, 1.0),
          end: Offset(0.0, 0.0),
        ).animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
