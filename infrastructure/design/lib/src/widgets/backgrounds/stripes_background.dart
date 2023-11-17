import 'package:deps/packages/awesome_extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

@UseCase(
  name: 'Stripes Background',
  type: StripesBackground,
)
Widget stripesBackground(BuildContext context) {
  return StripesBackground(
    stripeCount: context.knobs.int.input(
      label: 'Stripe Count',
      initialValue: 10,
    ),
    stripeWidth: context.knobs.double.slider(
      label: 'Stripe Width',
      initialValue: 2,
    ),
    direction: context.knobs.list(
      label: 'Direction',
      options: StripeDirection.values,
      labelBuilder: (o) => o.name.capitalizeFirst(),
    ),
    bgColor: context.knobs.color(
      label: 'Background Color',
      initialValue: context.theme.colorScheme.background,
    ),
    fgColor: context.knobs.color(
      label: 'Foreground Color',
      initialValue: context.theme.colorScheme.onBackground,
    ),
  );
}

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
      size: MediaQuery.of(context).size,
      painter: _StripesPainter(
        stripeCount: stripeCount,
        bgColor: bgColor ?? context.theme.colorScheme.background,
        fgColor: fgColor ?? context.theme.colorScheme.onBackground,
        direction: direction,
        stripeWidth: stripeWidth,
      ),
      child: child,
    );
  }
}

/// CustomPainter class for drawing the stripes pattern.
class _StripesPainter extends CustomPainter {
  _StripesPainter({
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
  final StripeDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    // Padding applied only for vertical stripes
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    // Fill the entire background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Update the paint color for the stripes
    paint.color = fgColor;

    // Calculate the spacing between stripes and adjust for padding if vertical
    final spacing = (direction == StripeDirection.horizontal)
        ? (size.height - stripeWidth) / (stripeCount - 1)
        : (size.width - stripeWidth) / (stripeCount - 1);

    // Loop to draw each stripe
    for (var i = 0; i < stripeCount; i++) {
      final start = i * spacing;
      if (direction == StripeDirection.horizontal) {
        // Drawing horizontal stripes
        canvas.drawRect(Rect.fromLTWH(0, start, size.width, stripeWidth), paint);
      } else {
        // Drawing vertical stripes
        canvas.drawRect(Rect.fromLTWH(start, 0, stripeWidth, size.height), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
