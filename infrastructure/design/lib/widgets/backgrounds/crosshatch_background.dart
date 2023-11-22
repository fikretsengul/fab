import 'package:deps/core/commons/extensions.dart';
import 'package:flutter/material.dart';

import 'others/crosshatch_background_painter.dart';

/// Enum defining the shapes for the crosshatch pattern: diamond or rectangle.
enum CrosshatchShape { diamond, rectangle }

/// A StatelessWidget that renders a crosshatch pattern as its background.
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

  /// Number of features (lines or diamonds) along one axis of the crosshatch pattern.
  final int featuresCount;

  /// Width of the stroke used in the crosshatch pattern.
  final double strokeWidth;

  /// Shape of the crosshatch pattern, either diamond or rectangle.
  final CrosshatchShape shape;

  /// Background color of the crosshatch pattern. Uses theme's background color if not specified.
  final Color? bgColor;

  /// Foreground color (color of the lines or diamonds). Uses theme's onBackground color if not specified.
  final Color? fgColor;

  /// An optional child widget to be rendered above the crosshatch pattern.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // CustomPaint widget is used for custom drawing of the crosshatch pattern.
    return CustomPaint(
      painter: CrosshatchBackgroundPainter(
        featuresCount: featuresCount,
        strokeWidth: strokeWidth,
        shape: shape,
        bgColor: bgColor ?? context.background,
        fgColor: fgColor ?? context.onBackground,
      ),
      child: child,
    );
  }
}
