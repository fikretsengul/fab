import 'package:flutter/material.dart';

enum Radiuses {
  /// None.
  none(4, topLeft: 4, topRight: 4, bottomLeft: 4, bottomRight: 4),

  /// 4px.
  sm(4, topLeft: 4, topRight: 4, bottomLeft: 4, bottomRight: 4),

  /// 8px.
  md(8, topLeft: 8, topRight: 8, bottomLeft: 8, bottomRight: 8),

  /// 16px.
  lg(16, topLeft: 16, topRight: 16, bottomLeft: 16, bottomRight: 16),

  /// 24px.
  xl(24, topLeft: 24, topRight: 24, bottomLeft: 24, bottomRight: 24);

  const Radiuses(
    this.px, {
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  final double px;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;

  Radius get circularRadius => Radius.circular(px);
  BorderRadius get circularBorder => BorderRadius.circular(px);

  BorderRadius only({bool tl = false, bool tr = false, bool bl = false, bool br = false}) => BorderRadius.only(
        topLeft: _rd(tl),
        topRight: _rd(tr),
        bottomLeft: _rd(bl),
        bottomRight: _rd(br),
      );
  BorderRadius horizontal({bool l = false, bool r = false}) => BorderRadius.horizontal(
        left: _rd(l),
        right: _rd(r),
      );
  BorderRadius vertical({bool t = false, bool b = false}) => BorderRadius.vertical(
        top: _rd(t),
        bottom: _rd(b),
      );

  Radius _rd(bool bl) => Radius.circular(bl ? px : 0);
}
