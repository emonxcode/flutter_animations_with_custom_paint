import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPaintFlutter extends StatefulWidget {
  const CustomPaintFlutter({super.key});

  @override
  State<CustomPaintFlutter> createState() => _CustomPaintFlutterState();
}

class _CustomPaintFlutterState extends State<CustomPaintFlutter> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CustomPaint(
            size: Size(size.width * 0.5, size.height * 0.1),
            painter: Rectangle(isFilled: false),
          ),
          const SizedBox(height: 10),
          CustomPaint(
            size: Size(size.width * 0.5, size.height * 0.1),
            painter: Line(),
          ),
          const SizedBox(height: 10),
          CustomPaint(
            size: Size(size.width * 0.5, size.height * 0.1),
            painter: Circle(),
          ),
          const SizedBox(height: 10),
          CustomPaint(
            size: Size(size.width * 0.5, size.height * 0.1),
            painter: Arc(),
          ),
        ],
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

    Offset offset = Offset(size.width * 0.5, size.height);

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
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;

    Offset startingOffset = Offset(0, size.height);
    Offset endingOffset = Offset(size.width, size.height);

    canvas.drawLine(startingOffset, endingOffset, paint);
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

    Offset offset = Offset(size.width * 0.5, size.height);
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
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height * 2);
    double startAngle = _degreeToRadians(0);
    double sweepAngle = _degreeToRadians(180);
    const useCenter = false;
    Paint paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
