import 'package:flutter/material.dart';

class CurvesClippers extends StatefulWidget {
  const CurvesClippers({super.key});

  @override
  State<CurvesClippers> createState() => _CurvesClippersState();
}

class _CurvesClippersState extends State<CurvesClippers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: HalfCircleClipper(side: CircleSide.left),
              child: Container(
                color: const Color.fromARGB(255, 10, 91, 156),
                height: 200,
                width: 200,
              ),
            ),
            ClipPath(
              clipper: HalfCircleClipper(side: CircleSide.right),
              child: Container(
                color: Colors.yellow,
                height: 200,
                width: 200,
              ),
            ),
          ],
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
