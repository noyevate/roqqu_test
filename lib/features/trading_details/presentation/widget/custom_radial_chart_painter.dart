import 'package:flutter/material.dart';
import 'dart:math'; 

class CustomRadialChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final totalRadius = min(size.width / 2, size.height / 2);


    final double outerRingThickness = totalRadius * 0.20; 
    final double innerRingThickness = totalRadius * 0.05; 

    final outerRingPaint = Paint()
      ..color = const Color.fromARGB(255, 233, 160, 42) 
      ..style = PaintingStyle.stroke 
      ..strokeWidth = outerRingThickness; 

    final innerRingPaint = Paint()
      ..color = const Color.fromARGB(255, 213, 140, 13) 
      ..style = PaintingStyle.stroke
      ..strokeWidth =  innerRingThickness; 


   final outerRingRadius = totalRadius - (outerRingThickness / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRingRadius),
      -pi / 2,
      2 * pi,
      false,
      outerRingPaint,
    );

    final innerRingRadius = outerRingRadius - (outerRingThickness / 2) - (innerRingThickness / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRingRadius),
      -pi / 2,
      2 * pi,
      false,
      innerRingPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}