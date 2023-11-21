import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

@UseCase(
  name: 'Dotted Background',
  type: DottedBackground,
)
Widget dottedBackground(BuildContext context) {
  return DottedBackground(
    rowCount: context.knobs.int.slider(
      label: 'Row Count',
      initialValue: 20,
      min: 1,
      max: 50,
    ),
    columnCount: context.knobs.int.slider(
      label: 'Column Count',
      initialValue: 15,
      min: 1,
      max: 50,
    ),
    shapeSize: context.knobs.double.slider(
      label: 'Shape Size',
      initialValue: 1,
    ),
    shape: context.knobs.list(
      label: 'Shape',
      options: DotsShape.values,
      labelBuilder: (o) => o.name.capitalizeFirst(),
    ),
    bgColor: context.knobs.color(
      label: 'Background Color',
      initialValue: context.background,
    ),
    evenColor: context.knobs.color(
      label: 'Even Shape Color',
      initialValue: context.onBackground,
    ),
    oddColor: context.knobs.color(
      label: 'Odd Shape Color',
      initialValue: Colors.grey,
    ),
    padding: context.knobs.double.input(
      label: 'Padding',
      initialValue: 10,
    ),
  );
}

/// Enum defining the shapes for the dots: regular dot, textured, or raindrop.
enum DotsShape { dot, texture }

/// A StatelessWidget that renders a background with a dotted pattern.
class DottedBackground extends StatelessWidget {
  const DottedBackground({
    this.rowCount = 20,
    this.columnCount = 15,
    this.shape = DotsShape.dot,
    this.shapeSize = 1,
    this.bgColor,
    this.evenColor,
    this.oddColor,
    this.padding = 10,
    this.child,
    super.key,
  });

  /// Number of rows of dots.
  final int rowCount;

  /// Number of columns of dots.
  final int columnCount;

  /// Shape of the dots in the pattern.
  final DotsShape shape;

  /// Size of each dot shape.
  final double shapeSize;

  /// Background color of the dotted pattern. Uses theme's background color if not specified.
  final Color? bgColor;

  /// Color for the even dots. If not specified, uses theme's onBackground color.
  final Color? evenColor;

  /// Color for the odd dots. Defaults to grey if not specified.
  final Color? oddColor;

  /// Padding around the pattern.
  final double padding;

  /// An optional child widget to be rendered above the dotted pattern.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // CustomPaint widget is used for custom drawing of the dotted pattern.
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _DottedBackgroundPainter(
        rowCount: rowCount,
        columnCount: columnCount,
        shapeSize: shapeSize,
        bgColor: bgColor ?? context.background,
        evenColor: shape == DotsShape.texture ? Colors.transparent : evenColor ?? context.onBackground,
        oddColor: oddColor ?? Colors.grey,
        padding: padding,
      ),
      child: child,
    );
  }
}

/// CustomPainter class for drawing the dotted pattern.
class _DottedBackgroundPainter extends CustomPainter {
  _DottedBackgroundPainter({
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
