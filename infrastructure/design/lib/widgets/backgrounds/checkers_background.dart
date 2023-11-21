import 'dart:math';

import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

@UseCase(
  name: 'Checkers Background',
  type: CheckersBackground,
)
Widget checkersBackground(BuildContext context) {
  return CheckersBackground(
    featuresCount: context.knobs.int.input(
      label: 'Features Count',
      initialValue: 10,
    ),
    pattern: context.knobs.list(
      label: 'Pattern',
      options: CheckerPattern.values,
      labelBuilder: (o) => o.name.capitalizeFirst(),
    ),
    bgColor: context.knobs.color(
      label: 'Background Color',
      initialValue: context.background,
    ),
    fgColor: context.knobs.color(
      label: 'Foreground Color',
      initialValue: context.onBackground,
    ),
  );
}

/// Enum defining the pattern types for the checkerboard: square or rectangle.
enum CheckerPattern { square, rectangle }

/// A StatelessWidget that renders a checkerboard pattern as its background.
class CheckersBackground extends StatelessWidget {
  const CheckersBackground({
    this.featuresCount = 10,
    this.pattern = CheckerPattern.rectangle,
    this.bgColor,
    this.fgColor,
    this.child,
    super.key,
  });

  /// Number of squares or rectangles along one axis of the checkerboard.
  final int featuresCount;

  /// Type of checkerboard pattern to render: square or rectangle.
  final CheckerPattern pattern;

  /// Background color of the checkerboard. Uses the theme's background color if not specified.
  final Color? bgColor;

  /// Foreground color for the squares or rectangles. Uses the theme's onBackground color if not specified.
  final Color? fgColor;

  /// An optional child widget to be rendered above the checkerboard pattern.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // CustomPaint widget is used to paint the checkerboard pattern.
    // CheckersPainter is responsible for the actual painting of the pattern.
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _CheckersPainter(
        featuresCount: featuresCount,
        bgColor: bgColor ?? context.background,
        fgColor: fgColor ?? context.onBackground,
        pattern: pattern,
      ),
      child: child,
    );
  }
}

/// CustomPainter class that handles painting the checkerboard pattern.
class _CheckersPainter extends CustomPainter {
  _CheckersPainter({
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
