import 'package:flutter/material.dart';

const crossWidgetColor = Color.fromARGB(255, 8, 144, 255);
const widgetStrokeWidth = 8.0;

class CrossWidget extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  const CrossWidget({
    super.key,
    this.color = crossWidgetColor,
    this.strokeWidth = widgetStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CrossPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _CrossPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CrossPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawLine(
      Offset(0.0, size.height),
      Offset(size.width, 0.0),
      painter,
    );

    canvas.drawLine(
      Offset(size.width, size.height),
      const Offset(0.0, 0.0),
      painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
