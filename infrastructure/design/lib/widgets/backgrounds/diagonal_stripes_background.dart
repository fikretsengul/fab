import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

@UseCase(
  name: 'Diagonal Stripes Background',
  type: DiagonalStripesBackground,
)
Widget diagonalStripesBackground(BuildContext context) {
  return DiagonalStripesBackground(
    stripeCount: context.knobs.int.input(
      label: 'Stripe Count',
      initialValue: 20,
    ),
    stripeWidth: context.knobs.double.slider(
      label: 'Stripe Width',
      initialValue: 2,
    ),
    direction: context.knobs.list(
      label: 'Direction',
      options: DiagonalStripeDirection.values,
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
      size: MediaQuery.of(context).size,
      painter: _DiagonalStripesPainter(
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

/// CustomPainter class for drawing the diagonal stripes pattern.
class _DiagonalStripesPainter extends CustomPainter {
  _DiagonalStripesPainter({
    required this.stripeCount,
    required this.stripeWidth,
    required this.bgColor,
    required this.fgColor,
    required this.direction,
  });
  final int stripeCount;
  final double stripeWidth;
  final Color bgColor;
  final Color fgColor;
  final DiagonalStripeDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for filling the stripes
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    // Fill the entire background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Update the paint color for the foreground stripes
    paint.color = fgColor;

    // Calculate the spacing between the start of each stripe
    final spacing = (size.width + size.height) / stripeCount;

    // Loop to draw each diagonal stripe
    for (var i = -size.height; i < size.width; i += spacing) {
      final path = Path();

      // Drawing stripes based on the specified direction
      if (direction == DiagonalStripeDirection.leftToRight) {
        // Diagonal stripes slanting from left to right
        path
          ..moveTo(size.width - i, 0)
          ..lineTo(size.width - (i + stripeWidth), 0)
          ..lineTo(size.width - (i + size.height + stripeWidth), size.height)
          ..lineTo(size.width - (i + size.height), size.height);
      } else {
        // Diagonal stripes slanting from right to left
        path
          ..moveTo(i, 0)
          ..lineTo(i + stripeWidth, 0)
          ..lineTo(i + size.height + stripeWidth, size.height)
          ..lineTo(i + size.height, size.height);
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
