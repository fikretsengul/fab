// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

enum Radiuses {
  none._(0),
  xs._(4),
  sm._(8),

  /// 12px
  md._(12),
  lg._(16),
  xl._(20),
  xxl._(24);

  const Radiuses._(this.value);
  final double value;
}

extension RadiusesExt on Radiuses {
  BorderRadius only({
    bool tl = false,
    bool tr = false,
    bool bl = false,
    bool br = false,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(tl ? value : 0),
        topRight: Radius.circular(tr ? value : 0),
        bottomLeft: Radius.circular(bl ? value : 0),
        bottomRight: Radius.circular(br ? value : 0),
      );
  BorderRadius get topLeft => BorderRadius.only(topLeft: Radius.circular(value));
  BorderRadius get topRight => BorderRadius.only(topRight: Radius.circular(value));
  BorderRadius get bottomLeft => BorderRadius.only(bottomLeft: Radius.circular(value));
  BorderRadius get bottomRight => BorderRadius.only(bottomRight: Radius.circular(value));
  BorderRadius get horizontal => BorderRadius.horizontal(left: Radius.circular(value), right: Radius.circular(value));
  BorderRadius get vertical => BorderRadius.vertical(top: Radius.circular(value), bottom: Radius.circular(value));
  BorderRadius get circularBorder => BorderRadius.all(Radius.circular(value));
  Radius get circularRadius => Radius.circular(value);
}
