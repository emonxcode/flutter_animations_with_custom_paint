import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPaintFlutter extends StatefulWidget {
  const CustomPaintFlutter({super.key});

  @override
  State<CustomPaintFlutter> createState() => _CustomPaintFlutterState();
}

class _CustomPaintFlutterState extends State<CustomPaintFlutter> {
  int index = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (index < 19) {
          index++;
        } else {
          index = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  color: Colors.deepOrange,
                  child: CustomPaint(
                    size: Size(size.width * 0.5, size.height * 0.1),
                    painter: Rectangle(isFilled: false),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.green,
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: Line(index: index),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.blue,
                  child: CustomPaint(
                    size: Size(size.width * 0.5, size.height * 0.1),
                    painter: Circle(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: Arc(),
                  ),
                ),
                const SizedBox(height: 10),
                CustomPaint(
                  size: Size(size.width * 0.5, size.height * 0.5),
                  painter: DrawPath(),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: CardWidget()),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.arrow_forward),
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// draw Rectangle
class Rectangle extends CustomPainter {
  bool? isFilled;
  Rectangle({required this.isFilled});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    if (isFilled!) {
      paint.style = PaintingStyle.fill;
    } else {
      paint.style = PaintingStyle.stroke;
    }
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeWidth = 5;

    Offset offset = Offset(size.width * 0.5, size.height * 0.5);

    Rect rect = Rect.fromCenter(center: offset, width: 50, height: 50);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant Rectangle oldDelegate) {
    return false;
  }
}

/// draw Line
class Line extends CustomPainter {
  Line({required this.index});
  int index = 0;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;

    final List<Offset> endingOffset = [
      Offset(size.width, 0),
      Offset(size.width, size.height * 0.2),
      Offset(size.width, size.height * 0.4),
      Offset(size.width, size.height * 0.6),
      Offset(size.width, size.height * 0.8),
      Offset(size.width, size.height),
      Offset(size.width * 0.8, size.height),
      Offset(size.width * 0.6, size.height),
      Offset(size.width * 0.4, size.height),
      Offset(size.width * 0.2, size.height),
      Offset(0, size.height),
      Offset(0, size.height * 0.8),
      Offset(0, size.height * 0.6),
      Offset(0, size.height * 0.4),
      Offset(0, size.height * 0.2),
      const Offset(0, 0),
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.4, 0),
      Offset(size.width * 0.6, 0),
      Offset(size.width * 0.8, 0),
    ];

    Offset startingOffset = Offset(size.width * 0.5, size.height * 0.5);

    canvas.drawLine(startingOffset, endingOffset[index], paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// draw Circle
class Circle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeWidth = 5;

    Offset offset = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(offset, 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// draw Arc
class Arc extends CustomPainter {
  double _degreeToRadians(num degree) {
    return (degree * math.pi) / 180.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width * 0.5, size.height * 0.5);
    Rect rect = Rect.fromCenter(center: offset, width: 150, height: 150);

    /// yellow arc
    double startAngle = _degreeToRadians(0);
    double sweepAngle = _degreeToRadians(90);

    /// green arc
    double startAngle2 = _degreeToRadians(90);
    double sweepAngle2 = _degreeToRadians(90);

    /// red arc
    double startAngle3 = _degreeToRadians(180);
    double sweepAngle3 = _degreeToRadians(90);

    /// blue arc
    double startAngle4 = _degreeToRadians(270);
    double sweepAngle4 = _degreeToRadians(45);

    const useCenter = false;

    /// yellow arc
    Paint paint1 = Paint();
    paint1.color = Colors.yellow;
    paint1.style = PaintingStyle.stroke;
    paint1.strokeWidth = 10;

    /// green arc
    Paint paint2 = Paint();
    paint2.color = Colors.green;
    paint2.style = PaintingStyle.stroke;
    paint2.strokeWidth = 10;

    /// red arc
    Paint paint3 = Paint();
    paint3.color = Colors.red;
    paint3.style = PaintingStyle.stroke;
    paint3.strokeWidth = 10;

    /// blue arc
    Paint paint4 = Paint();
    paint4.color = Colors.blue;
    paint4.style = PaintingStyle.stroke;
    paint4.strokeWidth = 10;

    /// green arc
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint1);

    /// yellow arc
    canvas.drawArc(rect, startAngle2, sweepAngle2, useCenter, paint2);

    /// red arc
    canvas.drawArc(rect, startAngle3, sweepAngle3, useCenter, paint3);

    /// blue arc
    canvas.drawArc(rect, startAngle4, sweepAngle4, useCenter, paint4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DrawPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height);
    //path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomPaint(
        painter: CardPainter(),
        child: Expanded(
            child: Container(
          decoration: const BoxDecoration(),
        )),
      ),
    );
  }
}

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = const Color.fromARGB(255, 255, 255, 255);
    paint.shader = const LinearGradient(
      colors: [Colors.blue, Colors.green], // Adjust gradient colors as needed
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    Path path = Path();
    path.moveTo(size.width * 0.8, size.height);
    path.quadraticBezierTo(size.width * 0.85, size.height * 0.98,
        size.width * 0.85, size.height * 0.9);

    path.quadraticBezierTo(size.width * 0.85, size.height * 0.7,
        size.width * 0.95, size.height * 0.7);

    path.quadraticBezierTo(
        size.width, size.height * 0.7, size.width, size.height * 0.6);

    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(size.width, 0, size.width * 0.9, 0);
    path.lineTo(size.width * 0.1, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.2);
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(0, size.height, size.width * 0.1, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
