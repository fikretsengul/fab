import 'package:flutter/material.dart';

enum Paddings {
  /// 4px.
  xxs(4, left: 4, top: 4, right: 4, bottom: 4),

  /// 8px.
  xs(8, left: 8, top: 8, right: 8, bottom: 8),

  /// 16px.
  sm(16, left: 16, top: 16, right: 16, bottom: 16),

  /// 24px.
  md(24, left: 24, top: 24, right: 24, bottom: 24),

  /// 32px.
  lg(32, left: 32, top: 32, right: 32, bottom: 32),

  /// 48px.
  xl(48, left: 48, top: 48, right: 48, bottom: 48),

  /// 56px.
  xxl(56, left: 56, top: 56, right: 56, bottom: 56);

  const Paddings(
    this.px, {
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  final double px;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  EdgeInsets get all => EdgeInsets.all(px);

  EdgeInsets only({bool l = false, bool t = false, bool r = false, bool b = false}) => EdgeInsets.fromLTRB(
        _pd(l),
        _pd(t),
        _pd(r),
        _pd(b),
      );

  EdgeInsets symmetric({bool h = false, bool v = false}) => EdgeInsets.symmetric(
        vertical: v ? _pd(v) : 0,
        horizontal: h ? _pd(h) : 0,
      );

  Widget get vertical => SizedBox(height: px);

  Widget get horizontal => SizedBox(width: px);

  double _pd(bool bl) => bl ? px : 0;
}
