import 'package:flutter/material.dart';

class CustomIndicatorShape extends ShapeBorder {
  CustomIndicatorShape({required this.borderSide, required this.borderRadius});
  final BorderSide borderSide;
  final BorderRadius borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderSide.width);

  @override
  ShapeBorder scale(double t) {
    return CustomIndicatorShape(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.toRRect(rect));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, borderSide.toPaint());
  }
}
