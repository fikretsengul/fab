import 'package:deps/core/commons/extensions.dart';
import 'package:flutter/material.dart';

import 'others/diagonal_stripes_background_painter.dart';

/// Enum defining the direction of the diagonal stripes: left-to-right or right-to-left.
enum DiagonalStripeDirection { leftToRight, rightToLeft }

/// A StatelessWidget that renders a background with diagonal stripes.
class DiagonalStripesBackground extends StatelessWidget {
  const DiagonalStripesBackground({
    this.stripeCount = 20,
    this.stripeWidth = 2,
    this.direction = DiagonalStripeDirection.leftToRight,
    this.bgColor,
    this.fgColor,
    this.child,
    super.key,
  });

  /// Number of stripes in the diagonal stripes pattern.
  final int stripeCount;

  /// Width of each individual stripe.
  final double stripeWidth;

  /// Direction of the diagonal stripes.
  final DiagonalStripeDirection direction;

  /// Background color of the stripes pattern. Uses theme's background color if not specified.
  final Color? bgColor;

  /// Foreground color of the stripes. Uses theme's onBackground color if not specified.
  final Color? fgColor;

  /// An optional child widget to be rendered above the stripes pattern.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // CustomPaint widget is used for custom drawing of the diagonal stripes.
    return CustomPaint(
      painter: DiagonalStripesBackgroundPainter(
        stripeCount: stripeCount,
        bgColor: bgColor ?? context.background,
        fgColor: fgColor ?? context.onBackground,
        direction: direction,
        stripeWidth: stripeWidth,
      ),
      child: child,
    );
  }
}
