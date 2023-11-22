import 'dart:math';

import 'package:flutter/material.dart';

import '../checkers_background.dart';

/// CustomPainter class that handles painting the checkerboard pattern.
class CheckersBackgroundPainter extends CustomPainter {
  CheckersBackgroundPainter({
    required this.featuresCount,
    required this.pattern,
    required this.bgColor,
    required this.fgColor,
  });
  final int featuresCount;
  final CheckerPattern pattern;
  final Color bgColor;
  final Color fgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Initialize the width and height for each checkerboard cell.
    double rectWidth;
    double rectHeight;

    // Determine cell size based on the pattern type.
    if (pattern == CheckerPattern.square) {
      // For square pattern, cells are squares with equal width and height.
      // The smallest side of the canvas is divided by the number of features to ensure fitting.
      final side = min(size.width, size.height) / featuresCount;
      rectWidth = side;
      rectHeight = side;
    } else {
      // For rectangle pattern, cells are rectangles that span evenly across the canvas.
      rectWidth = size.width / featuresCount;
      rectHeight = size.height / featuresCount;
    }

    // Paint the entire background first.
    paint.color = bgColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Loop through each cell and paint the foreground color to create the checkerboard effect.
    for (var j = 0; j * rectHeight < size.height; j++) {
      for (var i = 0; i * rectWidth < size.width; i++) {
        // The checkerboard pattern is achieved by filling every alternate cell.
        if ((i + j) % 2 != 0) {
          final rectX = i * rectWidth;
          final rectY = j * rectHeight;
          final rect = Rect.fromLTWH(rectX, rectY, rectWidth, rectHeight);

          paint.color = fgColor;
          canvas.drawRect(rect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
