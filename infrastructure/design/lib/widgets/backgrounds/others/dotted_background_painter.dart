import 'package:flutter/material.dart';

/// CustomPainter class for drawing the dotted pattern.
class DottedBackgroundPainter extends CustomPainter {
  DottedBackgroundPainter({
    required this.rowCount,
    required this.columnCount,
    required this.shapeSize,
    required this.bgColor,
    required this.evenColor,
    required this.oddColor,
    required this.padding,
  });
  final int rowCount;
  final int columnCount;
  final double shapeSize;
  final Color bgColor;
  final Color evenColor;
  final Color oddColor;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for filling the dots
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    // Fill the entire background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Calculate the effective area excluding padding and the spacing between dots
    final effectiveWidth = size.width - 2 * padding;
    final effectiveHeight = size.height - 2 * padding;
    final xSpacing = effectiveWidth / (columnCount - 1);
    final ySpacing = effectiveHeight / (rowCount - 1);

    // Loop to draw each dot
    for (var i = 0; i < rowCount; i++) {
      for (var j = 0; j < columnCount; j++) {
        paint.color = (i * columnCount + j).isEven ? evenColor : oddColor;
        canvas.drawCircle(
          Offset(padding + j * xSpacing, padding + i * ySpacing),
          shapeSize,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
