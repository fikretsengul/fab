import 'package:flutter/material.dart';

class CustomUnderlineTabIndicator extends Decoration {
  CustomUnderlineTabIndicator({required Color color, required double radius})
      : _painter = _CustomUnderlineTabIndicator(color, radius);
  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CustomUnderlineTabIndicator extends BoxPainter {
  _CustomUnderlineTabIndicator(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;
  final Paint _paint;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final customOffset = offset +
        Offset(
          configuration.size!.width / 2,
          configuration.size!.height - 2,
        );

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: customOffset,
          width: configuration.size!.width,
          height: 4,
        ),
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      _paint,
    );
  }
}
