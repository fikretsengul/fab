import 'package:deps/core/commons/extensions.dart';
import 'package:flutter/material.dart';

import 'others/dotted_background_painter.dart';

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
      painter: DottedBackgroundPainter(
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
