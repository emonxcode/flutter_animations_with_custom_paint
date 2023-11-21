import 'dart:async';
import 'dart:math' show pi;

import 'package:flutter/material.dart';

class CurvesClippers extends StatefulWidget {
  const CurvesClippers({super.key});

  @override
  State<CurvesClippers> createState() => _CurvesClippersState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _CurvesClippersState extends State<CurvesClippers>
    with TickerProviderStateMixin {
  late AnimationController _antiClockAnimationController;
  late Animation<double> _antiClockAnimation;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _antiClockAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _antiClockAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2), // 180 degree
    ).animate(
      CurvedAnimation(
        parent: _antiClockAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    /// flif animation
    _flipAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
          parent: _flipAnimationController, curve: Curves.bounceOut),
    );

    _antiClockAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
              parent: _flipAnimationController, curve: Curves.bounceOut),
        );

        // rest the flip controller and start the animation
        _flipAnimationController
          ..reset()
          ..forward();
      }
    });

    _flipAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _antiClockAnimation = Tween<double>(
          begin: _antiClockAnimation.value,
          end: _antiClockAnimation.value + -(pi / 2),
        ).animate(
          CurvedAnimation(
            parent: _antiClockAnimationController,
            curve: Curves.bounceOut,
          ),
        );

        _antiClockAnimationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _antiClockAnimationController.dispose();
    _flipAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _antiClockAnimationController
    //   ..reset()
    //   ..forward.delayed(const Duration(seconds: 1));

    Future.delayed(const Duration(seconds: 6)).then((value) {
      _antiClockAnimationController
        ..reset() // start from 0
        ..forward();
    });

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _antiClockAnimationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(_antiClockAnimation.value),
              child: child,
            );
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) => Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..rotateY(_flipAnimation.value),
                    child: ClipPath(
                      clipper: HalfCircleClipper(side: CircleSide.left),
                      child: Container(
                        color: const Color.fromARGB(255, 10, 91, 156),
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) => Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..rotateY(_flipAnimation.value),
                    child: ClipPath(
                      clipper: HalfCircleClipper(side: CircleSide.right),
                      child: Container(
                        color: Colors.yellow,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }

    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockWise,
    );
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
