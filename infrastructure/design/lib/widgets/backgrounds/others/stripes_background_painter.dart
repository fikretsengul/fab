import 'package:flutter/material.dart';

import '../stripes_background.dart';

/// CustomPainter class for drawing the stripes pattern.
class StripesBackgroundPainter extends CustomPainter {
  StripesBackgroundPainter({
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
