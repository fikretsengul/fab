import 'package:deps/core/commons/extensions.dart';
import 'package:flutter/material.dart';

import 'others/stripes_background_painter.dart';

/// Enum defining the direction of the stripes: horizontal or vertical.
enum StripeDirection { horizontal, vertical }

/// A StatelessWidget that renders a background with stripes.
class StripesBackground extends StatelessWidget {
  const StripesBackground({
    this.stripeCount = 10,
    this.stripeWidth = 2,
    this.bgColor,
    this.fgColor,
    this.direction = StripeDirection.vertical,
    this.child,
    super.key,
  });

  /// Number of stripes in the pattern.
  final int stripeCount;

  /// Width of each stripe.
  final double stripeWidth;

  /// Background color of the stripes pattern. Uses theme's background color if not specified.
  final Color? bgColor;

  /// Foreground color of the stripes. Uses theme's onBackground color if not specified.
  final Color? fgColor;

  /// Direction of the stripes: horizontal or vertical.
  final StripeDirection direction;

  /// An optional child widget to be rendered above the stripes pattern.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // CustomPaint widget is used for custom drawing of the stripes pattern.
    return CustomPaint(
      painter: StripesBackgroundPainter(
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
