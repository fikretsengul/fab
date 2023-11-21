import 'package:flutter/material.dart';

/// Custom painter for painting the background highlight with an offset.
class HighlightedTextPainter extends CustomPainter {
  HighlightedTextPainter({
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.offset,
  });

  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    // Create a TextSpan and TextPainter to calculate the size of the text.
    final span = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    )..layout();

    // Calculate the adjusted offset for the background rectangle.
    final adjustedOffset = Offset(offset.dx, offset.dy + 5);

    // Paint the background rectangle with the adjusted offset.
    final backgroundPaint = Paint()..color = backgroundColor;
    final backgroundRect = adjustedOffset & Size(textPainter.width, textPainter.height / 1.5);
    canvas.drawRect(backgroundRect, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
