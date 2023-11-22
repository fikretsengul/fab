import 'package:deps/core/commons/extensions.dart';
import 'package:flutter/material.dart';

import 'others/checkers_background_painter.dart';

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
      painter: CheckersBackgroundPainter(
        featuresCount: featuresCount,
        bgColor: bgColor ?? context.background,
        fgColor: fgColor ?? context.onBackground,
        pattern: pattern,
      ),
      child: child,
    );
  }
}
