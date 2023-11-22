import 'package:flutter/material.dart';

import '../crosshatch_background.dart';

/// CustomPainter class for drawing the crosshatch pattern.
class CrosshatchBackgroundPainter extends CustomPainter {
  CrosshatchBackgroundPainter({
    required this.featuresCount,
    required this.strokeWidth,
    required this.shape,
    required this.bgColor,
    required this.fgColor,
  });
  final int featuresCount;
  final double strokeWidth;
  final CrosshatchShape shape;
  final Color bgColor;
  final Color fgColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Separate Paint objects for filling and stroking to avoid border effects
    final paintFill = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = fgColor
      ..strokeWidth = strokeWidth;

    // Fill the entire background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintFill);

    // Calculate the size of each crosshatch cell
    final squareSize = size.width / featuresCount;

    // Loop to draw the crosshatch pattern
    for (var y = 0.0; y <= size.height; y += squareSize) {
      for (var x = 0.0; x <= size.width; x += squareSize) {
        // Determine the shape to draw: diamond or rectangle
        switch (shape) {
          case CrosshatchShape.diamond:
            // Draw diamond shapes at each intersection
            canvas.drawLine(Offset(x, y), Offset(x + squareSize, y + squareSize), paintStroke);
            canvas.drawLine(Offset(x + squareSize, y), Offset(x, y + squareSize), paintStroke);
          case CrosshatchShape.rectangle:
            // Draw rectangles by connecting midpoints of each square's sides
            canvas.drawLine(Offset(x, y + squareSize / 2), Offset(x + squareSize, y + squareSize / 2), paintStroke);
            canvas.drawLine(Offset(x + squareSize / 2, y), Offset(x + squareSize / 2, y + squareSize), paintStroke);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
