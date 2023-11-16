import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

enum StripeDirection { horizontal, vertical }

class StripesBackground extends StatelessWidget {
  const StripesBackground({
    this.stripeCount = 10,
    this.stripeWidth = 5,
    this.bgColor,
    this.fgColor,
    this.direction = StripeDirection.horizontal,
    this.child,
    super.key,
  });

  final int stripeCount;
  final double stripeWidth;
  final Color? bgColor;
  final Color? fgColor;
  final StripeDirection direction;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StripesPainter(
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

class StripesPainter extends CustomPainter {
  StripesPainter({
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
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    // Paint the background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Set the color for the stripes
    paint.color = fgColor;

    // Calculate the spacing between the start of each stripe
    final spacing = (direction == StripeDirection.horizontal)
        ? (size.height - stripeWidth) / (stripeCount - 1)
        : (size.width - stripeWidth) / (stripeCount - 1);

    // Draw the stripes
    for (var i = 0; i < stripeCount; i++) {
      final start = i * spacing;
      if (direction == StripeDirection.horizontal) {
        // Draw horizontal stripes
        canvas.drawRect(Rect.fromLTWH(0, start, size.width, stripeWidth), paint);
      } else {
        // Draw vertical stripes
        canvas.drawRect(Rect.fromLTWH(start, 0, stripeWidth, size.height), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
