import 'package:flutter/material.dart';

enum TabIndicatorAlignVertical {
  center,
  up,
  down,
}

class TabIndicator extends Decoration {
  const TabIndicator({
    this.height = 2,
    this.color = Colors.redAccent,
    this.width = 0,
    this.radius = 1,
    this.padding = EdgeInsets.zero,
    this.align = TabIndicatorAlignVertical.down,
  });
  final double height;
  final double width;
  final double radius;
  final Color color;
  final TabIndicatorAlignVertical align;
  @override
  final EdgeInsetsGeometry padding;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is TabIndicator) {
      return TabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is TabIndicator) {
      return TabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TabIndicatorPainter(this, onChanged);
  }
}

class _TabIndicatorPainter extends BoxPainter {
  _TabIndicatorPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  final TabIndicator decoration;
  double get indicatorHeight => decoration.height;
  double get indicatorWidth => decoration.width;
  Color get indicatorColor => decoration.color;
  double get indicatorRadius => decoration.radius;
  EdgeInsetsGeometry get padding => decoration.padding;
  TabIndicatorAlignVertical get align => decoration.align;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final indicator = padding.resolve(textDirection).deflateRect(rect);

    final width = indicatorWidth > 0 ? indicatorWidth : indicator.width;
    final height = indicatorHeight > 0 ? indicatorHeight : indicator.height;
    final left = (indicator.left + indicator.right - width) * 0.5;
    double top;

    switch (align) {
      case TabIndicatorAlignVertical.up:
        top = indicator.top;
      case TabIndicatorAlignVertical.down:
        top = indicator.bottom - height;
      default:
        top = (indicator.height - height) * 0.5;
        break;
    }
    return Rect.fromLTWH(
      left,
      top,
      width,
      height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final rect = offset & configuration.size!;
    final textDirection = configuration.textDirection!;
    final indicator = _indicatorRectFor(rect, textDirection);
    final paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)),
      paint,
    );
  }
}
