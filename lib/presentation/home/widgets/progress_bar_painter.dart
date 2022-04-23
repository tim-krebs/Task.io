import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  double maxBarWidth;
  double barHeight;
  double donePercent;
  Color defaultColor;
  Color percentageColor;

  ProgressPainter(
      {required this.barHeight,
      required this.maxBarWidth,
      required this.donePercent,
      required this.defaultColor,
      required this.percentageColor});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultBarPaint = getPaint(defaultColor);
    Paint percentageBarPaint = getPaint(percentageColor);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset(-(maxBarWidth / 2), -(barHeight / 2)) &
              Size(maxBarWidth, barHeight),
          Radius.circular(barHeight / 2),
        ),
        defaultBarPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset(-(maxBarWidth / 2), -(barHeight / 2)) &
              Size(maxBarWidth * donePercent, barHeight),
          Radius.circular(barHeight / 2),
        ),
        percentageBarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
