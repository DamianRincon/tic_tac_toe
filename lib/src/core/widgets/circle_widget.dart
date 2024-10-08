import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/core/common/colors.dart';

const widgetStrokeWidth = 8.0;
const circleWidgetColor = MColors.red;

class CircleWidget extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  const CircleWidget({
    super.key,
    this.color = circleWidgetColor,
    this.strokeWidth = widgetStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CirclePainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
