import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

enum DiagonalStripeDirection { leftToRight, rightToLeft }

class DiagonalStripesBackground extends StatelessWidget {
  const DiagonalStripesBackground({
    this.stripeCount = 20,
    this.bgColor,
    this.fgColor,
    this.direction = DiagonalStripeDirection.leftToRight,
    this.stripeWidth = 5,
    this.child,
    super.key,
  });

  final int stripeCount;
  final Color? bgColor;
  final Color? fgColor;
  final DiagonalStripeDirection direction;
  final double stripeWidth;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalStripesPainter(
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

class DiagonalStripesPainter extends CustomPainter {
  DiagonalStripesPainter({
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
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    // Paint the background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Foreground stripes
    paint.color = fgColor;

    // The spacing between the start of each stripe, accounting for stripe width
    final spacing = (size.width + size.height) / stripeCount;

    for (var i = -size.height; i < size.width; i += spacing) {
      final path = Path();

      if (direction == DiagonalStripeDirection.leftToRight) {
        // Draw stripes from left to right
        path
          ..moveTo(size.width - i, 0)
          ..lineTo(size.width - (i + stripeWidth), 0)
          ..lineTo(size.width - (i + size.height + stripeWidth), size.height)
          ..lineTo(size.width - (i + size.height), size.height);
      } else {
        // Draw stripes from right to left
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
