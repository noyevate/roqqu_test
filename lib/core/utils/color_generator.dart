import 'package:flutter/material.dart';

class ColorGenerator {
  ColorGenerator._();

  static Color fromName(String name) {
  
    final int hue = name.hashCode % 360;
    final HSLColor hslColor = HSLColor.fromAHSL(1.0, hue.toDouble(), 0.7, 0.5);
    return hslColor.toColor();
  }
}