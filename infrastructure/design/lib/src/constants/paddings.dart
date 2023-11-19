// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// `Paddings` is an enumeration that defines standard padding sizes.
/// It provides a set of predefined padding values, allowing for consistent spacing
/// throughout the application's UI. Each enum value includes padding sizes for all
/// directions and methods to apply these paddings in different ways.
enum Paddings {
  /// Extra-extra-small padding of 4 pixels.
  xxs(4, left: 4, top: 4, right: 4, bottom: 4),

  /// Extra-small padding of 8 pixels.
  xs(8, left: 8, top: 8, right: 8, bottom: 8),

  /// Small padding of 12 pixels.
  sm(12, left: 12, top: 12, right: 12, bottom: 12),

  /// Medium padding of 16 pixels.
  md(16, left: 16, top: 16, right: 16, bottom: 16),

  /// Large padding of 24 pixels.
  lg(24, left: 24, top: 24, right: 24, bottom: 24),

  /// Extra-large padding of 32 pixels.
  xl(32, left: 32, top: 32, right: 32, bottom: 32),

  /// Extra-extra-large padding of 40 pixels.
  xxl(40, left: 40, top: 40, right: 40, bottom: 40);

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

  /// Creates `EdgeInsets` with padding applied to all sides.
  EdgeInsets get all => EdgeInsets.all(px);

  /// Creates `EdgeInsets` with selective padding applied to specified sides.
  /// [l]: Apply left padding.
  /// [t]: Apply top padding.
  /// [r]: Apply right padding.
  /// [b]: Apply bottom padding.
  EdgeInsets only({bool l = false, bool t = false, bool r = false, bool b = false}) => EdgeInsets.fromLTRB(
        _pd(l),
        _pd(t),
        _pd(r),
        _pd(b),
      );

  /// Creates `EdgeInsets` with symmetric padding applied vertically or horizontally.
  /// [h]: Apply horizontal padding.
  /// [v]: Apply vertical padding.
  EdgeInsets symmetric({bool h = false, bool v = false}) => EdgeInsets.symmetric(
        vertical: v ? _pd(v) : 0,
        horizontal: h ? _pd(h) : 0,
      );

  /// Returns a `SizedBox` with vertical space of padding size.
  Widget get vertical => SizedBox(height: px);

  /// Returns a `SizedBox` with horizontal space of padding size.
  Widget get horizontal => SizedBox(width: px);

  /// Helper method to determine if padding should be applied.
  double _pd(bool bl) => bl ? px : 0;
}
