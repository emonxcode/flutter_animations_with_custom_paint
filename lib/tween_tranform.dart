import 'dart:math';

import 'package:flutter/material.dart';

class TweenTransform extends StatefulWidget {
  const TweenTransform({super.key, required this.title});
  final String title;

  @override
  State<TweenTransform> createState() => _TweenTransformState();
}

class _TweenTransformState extends State<TweenTransform>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_animationController);
    _animationController.repeat();
  }

  /*
   0.0 = 0 degrees
   0.5 = 180 degrees
   1.0 = 360 degrees
  */

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateZ(_animation.value),
            // transform: Matrix4.identity()..rotateX(_animation.value),
            // transform: Matrix4.identity()..rotateY(_animation.value),
            child: child,
          ),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
