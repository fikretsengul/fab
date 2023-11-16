import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

enum DotsShape { dot, texture, raindrop }

class DottedBackground extends StatelessWidget {
  const DottedBackground({
    this.rowCount = 20,
    this.columnCount = 15,
    this.shapeSize = 5,
    this.bgColor,
    this.evenColor,
    this.oddColor,
    this.padding = 10,
    this.child,
    super.key,
  });

  final int rowCount;
  final int columnCount;
  final int shapeSize;
  final Color? bgColor;
  final Color? evenColor;
  final Color? oddColor;
  final double padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBackgroundPainter(
        rowCount: rowCount,
        columnCount: columnCount,
        shapeSize: shapeSize,
        bgColor: bgColor ?? context.theme.colorScheme.background,
        evenColor: evenColor ?? context.theme.colorScheme.onBackground,
        oddColor: oddColor ?? Colors.grey,
        padding: 16,
      ),
      child: child,
    );
  }
}

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
  final int shapeSize;
  final Color bgColor;
  final Color evenColor;
  final Color oddColor;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    // Paint the background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final effectiveWidth = size.width - 2 * padding; // Width minus padding
    final effectiveHeight = size.height - 2 * padding; // Height minus padding
    final xSpacing = effectiveWidth / (columnCount - 1);
    final ySpacing = effectiveHeight / (rowCount - 1);

    for (var i = 0; i < rowCount; i++) {
      for (var j = 0; j < columnCount; j++) {
        paint.color = (i * columnCount + j).isEven ? evenColor : oddColor;
        canvas.drawCircle(
          Offset(padding + j * xSpacing, padding + i * ySpacing),
          shapeSize.toDouble(),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
