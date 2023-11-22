import 'package:flutter/material.dart';

import '../diagonal_stripes_background.dart';

/// CustomPainter class for drawing the diagonal stripes pattern.
class DiagonalStripesBackgroundPainter extends CustomPainter {
  DiagonalStripesBackgroundPainter({
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
