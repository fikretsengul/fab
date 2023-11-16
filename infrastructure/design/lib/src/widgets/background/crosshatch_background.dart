import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

enum CrosshatchShape { diamond, rectangle }

class CrosshatchBackground extends StatelessWidget {
  const CrosshatchBackground({
    this.featuresCount = 10,
    this.strokeWidth = 1,
    this.shape = CrosshatchShape.rectangle,
    this.bgColor,
    this.fgColor,
    this.child,
    super.key,
  });

  final int featuresCount;
  final double strokeWidth;
  final CrosshatchShape shape;
  final Color? bgColor;
  final Color? fgColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CrosshatchPainter(
        featuresCount: featuresCount,
        strokeWidth: strokeWidth,
        shape: shape,
        bgColor: bgColor ?? context.theme.colorScheme.background,
        fgColor: fgColor ?? context.theme.colorScheme.onBackground,
      ),
      child: child,
    );
  }
}

class CrosshatchPainter extends CustomPainter {
  CrosshatchPainter({
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
    // Use two separate Paint objects to avoid a border effect
    final paintFill = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = fgColor
      ..strokeWidth = strokeWidth;

    // Fill the background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintFill);

    // Calculate the size of the squares based on the features count
    final squareSize = size.width / featuresCount;

    for (var y = 0.0; y <= size.height; y += squareSize) {
      for (var x = 0.0; x <= size.width; x += squareSize) {
        switch (shape) {
          case CrosshatchShape.diamond:
            // Draw the diamond shape with acute angles
            canvas.drawLine(Offset(x, y), Offset(x + squareSize, y + squareSize), paintStroke);
            canvas.drawLine(Offset(x + squareSize, y), Offset(x, y + squareSize), paintStroke);
          case CrosshatchShape.rectangle:
            // Draw horizontal and vertical lines to form rectangles
            canvas.drawLine(Offset(x, y + squareSize / 2), Offset(x + squareSize, y + squareSize / 2), paintStroke);
            canvas.drawLine(Offset(x + squareSize / 2, y), Offset(x + squareSize / 2, y + squareSize), paintStroke);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
