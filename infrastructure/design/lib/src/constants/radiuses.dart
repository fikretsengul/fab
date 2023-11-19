// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// `Radiuses` is an enumeration that defines standard border radius sizes.
/// It provides a set of predefined radius values, allowing for consistent border
/// styling throughout the application's UI. Each enum value includes radius sizes for all
/// corners and methods to apply these radii in different ways.
enum Radiuses {
  /// No radius (effectively a radius of 4 pixels).
  none(4, topLeft: 4, topRight: 4, bottomLeft: 4, bottomRight: 4),

  /// Small radius of 4 pixels.
  sm(4, topLeft: 4, topRight: 4, bottomLeft: 4, bottomRight: 4),

  /// Medium radius of 8 pixels.
  md(8, topLeft: 8, topRight: 8, bottomLeft: 8, bottomRight: 8),

  /// Large radius of 16 pixels.
  lg(16, topLeft: 16, topRight: 16, bottomLeft: 16, bottomRight: 16),

  /// Extra-large radius of 24 pixels.
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

  /// Creates a circular `Radius` with the defined size.
  Radius get circularRadius => Radius.circular(px);

  /// Creates a `BorderRadius` with the defined size applied uniformly to all corners.
  BorderRadius get circularBorder => BorderRadius.all(Radius.circular(px));

  /// Creates a `BorderRadius` with selective radius applied to specified corners.
  /// [tl]: Apply radius to top left.
  /// [tr]: Apply radius to top right.
  /// [bl]: Apply radius to bottom left.
  /// [br]: Apply radius to bottom right.
  BorderRadius only({bool tl = false, bool tr = false, bool bl = false, bool br = false}) => BorderRadius.only(
        topLeft: _rd(tl),
        topRight: _rd(tr),
        bottomLeft: _rd(bl),
        bottomRight: _rd(br),
      );

  /// Creates a `BorderRadius` with symmetric radius applied horizontally or vertically.
  /// [l]: Apply radius to left side.
  /// [r]: Apply radius to right side.
  BorderRadius horizontal({bool l = false, bool r = false}) => BorderRadius.horizontal(
        left: _rd(l),
        right: _rd(r),
      );

  /// Creates a `BorderRadius` with symmetric radius applied to top and bottom.
  /// [t]: Apply radius to top side.
  /// [b]: Apply radius to bottom side.
  BorderRadius vertical({bool t = false, bool b = false}) => BorderRadius.vertical(
        top: _rd(t),
        bottom: _rd(b),
      );

  /// Helper method to determine if radius should be applied.
  Radius _rd(bool bl) => Radius.circular(bl ? px : 0);
}
