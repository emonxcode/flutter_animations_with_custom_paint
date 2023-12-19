import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Flutter3DAnimations extends StatefulWidget {
  const Flutter3DAnimations({super.key});

  @override
  State<Flutter3DAnimations> createState() => _Flutter3DAnimationsState();
}

class _Flutter3DAnimationsState extends State<Flutter3DAnimations>
    with TickerProviderStateMixin {
  var size = 100.0;
  late AnimationController _xAnimationController;
  late AnimationController _yAnimationController;
  late AnimationController _zAnimationController;
  late Tween<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _xAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _yAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _zAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _animation = Tween<double>(begin: 0.0, end: pi * 2)
      ..animate(_xAnimationController);


       _xAnimationController
      ..reset()
      ..repeat();

    _yAnimationController
      ..reset()
      ..repeat();

    _zAnimationController
      ..reset()
      ..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _xAnimationController.dispose();
    _yAnimationController.dispose();
    _zAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xAnimationController,
                _yAnimationController,
                _zAnimationController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xAnimationController))
                    ..rotateY(_animation.evaluate(_yAnimationController))
                    ..rotateX(_animation.evaluate(_zAnimationController)),
                  child: Stack(
                    children: [
                      // back
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(
                            Vector3(
                              0,
                              0,
                              -size,
                            ),
                          ),
                        child: Container(
                          width: size,
                          height: size,
                          color: const Color.fromARGB(255, 95, 95, 95),
                          child: const Center(
                            child: Text("Back"),
                          ),
                        ),
                      ),
                      // bottom
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX((pi / 2)),
                        child: Container(
                          width: size,
                          height: size,
                          color: const Color.fromARGB(255, 70, 70, 70),
                          child: const Center(
                            child: Text("Bottom"),
                          ),
                        ),
                      ),
                      // left
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          width: size,
                          height: size,
                          color: const Color.fromARGB(255, 116, 116, 116),
                          child: const Center(
                            child: Text("Left"),
                          ),
                        ),
                      ),
                      // right
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-(pi / 2)),
                        child: Container(
                          width: size,
                          height: size,
                          color: const Color.fromARGB(255, 97, 97, 97),
                          child: const Center(
                            child: Text("Right"),
                          ),
                        ),
                      ),
                      // top
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-(pi / 2)),
                        child: Container(
                          width: size,
                          height: size,
                          color: Color.fromARGB(255, 104, 104, 104),
                          child: const Center(
                            child: Text("Top"),
                          ),
                        ),
                      ),
                      // front
                      Container(
                        width: size,
                        height: size,
                        color: const Color.fromARGB(255, 77, 77, 77),
                        child: const Center(
                          child: Text("Front"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: null,
            ),
          ],
        ),
      )),
    );
  }
}
