import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

@UseCase(
  name: 'Crosshatch Background',
  type: CrosshatchBackground,
)
Widget crosshatchBackground(BuildContext context) {
  return CrosshatchBackground(
    featuresCount: context.knobs.int.input(
      label: 'Features Count',
      initialValue: 10,
    ),
    strokeWidth: context.knobs.double.slider(
      label: 'Stroke Width',
      initialValue: 1,
    ),
    shape: context.knobs.list(
      label: 'Shape',
      options: CrosshatchShape.values,
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

/// Enum defining the shapes for the crosshatch pattern: diamond or rectangle.
enum CrosshatchShape { diamond, rectangle }

/// A StatelessWidget that renders a crosshatch pattern as its background.
class CrosshatchBackground extends StatelessWidget {
  const CrosshatchBackground({
    this.featuresCount = 10,
    this.strokeWidth = 1,
    this.shape = CrosshatchShape.rectangle,
    this.bgColor,
    this.fgColor,
    this.child,
    super.key,
  });

  /// Number of features (lines or diamonds) along one axis of the crosshatch pattern.
  final int featuresCount;

  /// Width of the stroke used in the crosshatch pattern.
  final double strokeWidth;

  /// Shape of the crosshatch pattern, either diamond or rectangle.
  final CrosshatchShape shape;

  /// Background color of the crosshatch pattern. Uses theme's background color if not specified.
  final Color? bgColor;

  /// Foreground color (color of the lines or diamonds). Uses theme's onBackground color if not specified.
  final Color? fgColor;

  /// An optional child widget to be rendered above the crosshatch pattern.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // CustomPaint widget is used for custom drawing of the crosshatch pattern.
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _CrosshatchPainter(
        featuresCount: featuresCount,
        strokeWidth: strokeWidth,
        shape: shape,
        bgColor: bgColor ?? context.background,
        fgColor: fgColor ?? context.onBackground,
      ),
      child: child,
    );
  }
}

/// CustomPainter class for drawing the crosshatch pattern.
class _CrosshatchPainter extends CustomPainter {
  _CrosshatchPainter({
    required this.featuresCount,
    required this.strokeWidth,
    required this.shape,
    required this.bgColor,
    required this.fgColor,
  });
  final int featuresCount;
  final double strokeWidth;
  final CrosshatchShape shape;
  final Color bgColor;
  final Color fgColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Separate Paint objects for filling and stroking to avoid border effects
    final paintFill = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = fgColor
      ..strokeWidth = strokeWidth;

    // Fill the entire background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintFill);

    // Calculate the size of each crosshatch cell
    final squareSize = size.width / featuresCount;

    // Loop to draw the crosshatch pattern
    for (var y = 0.0; y <= size.height; y += squareSize) {
      for (var x = 0.0; x <= size.width; x += squareSize) {
        // Determine the shape to draw: diamond or rectangle
        switch (shape) {
          case CrosshatchShape.diamond:
            // Draw diamond shapes at each intersection
            canvas.drawLine(Offset(x, y), Offset(x + squareSize, y + squareSize), paintStroke);
            canvas.drawLine(Offset(x + squareSize, y), Offset(x, y + squareSize), paintStroke);
          case CrosshatchShape.rectangle:
            // Draw rectangles by connecting midpoints of each square's sides
            canvas.drawLine(Offset(x, y + squareSize / 2), Offset(x + squareSize, y + squareSize / 2), paintStroke);
            canvas.drawLine(Offset(x + squareSize / 2, y), Offset(x + squareSize / 2, y + squareSize), paintStroke);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
