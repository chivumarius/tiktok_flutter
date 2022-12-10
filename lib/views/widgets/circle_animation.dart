import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  // ♦ Property:
  final Widget child;

  // ♦ Constructor:
  const CircleAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  // ♦ Controller:
  late AnimationController controller;

  // ♦ The "initState()" Method
  //    → to Animate the "Controller":
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 5000,
      ),
    );
    controller.forward();
    controller.repeat();
  }

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      // ♦ A "Linear Interpolati"on
      //   → between a "Beginning Value" and an "Ending Value":
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child,
    );
  }
}
