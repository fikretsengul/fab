// ignore_for_file: max_lines_for_file
import 'package:flutter/cupertino.dart';

import '../../_core/constants/fab_theme.dart';

class FabCard extends StatelessWidget {
  FabCard({
    super.key,
    this.width,
    this.height,
    this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.color,
    this.radius = 16,
    this.image,
    this.onPressed,
    this.border,
    this.pressedOpacity = 0.4,
    this.useCupertinoRounder = false,
  });

  final double pressedOpacity;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final EdgeInsets margin;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final double radius;
  final DecorationImage? image;
  final BoxBorder? border;
  final bool useCupertinoRounder;

  @override
  Widget build(BuildContext context) {
    final shapeborder = SquircleBorder(
      radius: BorderRadius.all(
        Radius.circular(
          radius,
        ),
      ),
    );

    final widget = CupertinoButton(
      pressedOpacity: pressedOpacity,
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: !useCupertinoRounder ? BorderRadius.all(Radius.circular(radius)) : null,
          color: color ?? context.fabTheme.surfaceColor,
          image: image,
          border: border,
        ),
        child: child,
      ),
    );

    return useCupertinoRounder
        ? ClipPath.shape(
            shape: shapeborder,
            child: widget,
          )
        : widget;
  }
}

Path squirclePath(Rect rect, BorderRadius? radius) {
  final c = rect.center;
  final startX = rect.left;
  final endX = rect.right;
  final startY = rect.top;
  final endY = rect.bottom;

  final midX = c.dx;
  final midY = c.dy;

  if (radius == null) {
    return Path()
      ..moveTo(startX, midY)
      ..cubicTo(startX, startY, startX, startY, midX, startY)
      ..cubicTo(endX, startY, endX, startY, endX, midY)
      ..cubicTo(endX, endY, endX, endY, midX, endY)
      ..cubicTo(startX, endY, startX, endY, startX, midY)
      ..close();
  }

  return Path()

    // Start position
    ..moveTo(startX, startY + radius.topLeft.y)

    // top left corner
    ..cubicTo(
      startX,
      startY,
      startX,
      startY,
      startX + radius.topLeft.x,
      startY,
    )

    // top line
    ..lineTo(endX - radius.topRight.x, startY)

    // top right corner
    ..cubicTo(
      endX,
      startY,
      endX,
      startY,
      endX,
      startY + radius.topRight.y,
    )

    // right line
    ..lineTo(endX, endY - radius.bottomRight.y)

    // bottom right corner
    ..cubicTo(
      endX,
      endY,
      endX,
      endY,
      endX - radius.bottomRight.x,
      endY,
    )

    // bottom line
    ..lineTo(startX + radius.bottomLeft.x, endY)

    // bottom left corner
    ..cubicTo(
      startX,
      endY,
      startX,
      endY,
      startX,
      endY - radius.bottomLeft.y,
    )

    // left line
    //..moveTo(startX, startY + radius)
    ..close();
}

class SquircleBorder extends ShapeBorder {
  const SquircleBorder({
    this.side = BorderSide.none,
    this.radius,
  });

  final BorderRadius? radius;
  final BorderSide side;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return squirclePath(rect.deflate(side.width), radius);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return squirclePath(rect, radius);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final path = getOuterPath(
          rect.deflate(side.width / 2.0),
          textDirection: textDirection,
        );
        canvas.drawPath(path, side.toPaint());
    }
  }

  @override
  ShapeBorder scale(double t) {
    return SquircleBorder(
      side: side.scale(t),
      radius: radius,
    );
  }
}
