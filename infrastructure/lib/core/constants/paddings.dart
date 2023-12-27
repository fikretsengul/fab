// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

enum Paddings {
  xxs._(4),
  xs._(8),
  sm._(12),
  md._(16),
  lg._(24),
  xl._(32),
  xxl._(40);

  const Paddings._(this.value);
  final double value;
}

extension PaddingsExt on Paddings {
  EdgeInsets only({
    bool l = false,
    bool r = false,
    bool t = false,
    bool b = false,
  }) =>
      EdgeInsets.fromLTRB(
        l ? value : 0,
        t ? value : 0,
        r ? value : 0,
        b ? value : 0,
      );
  EdgeInsets get left => EdgeInsets.only(left: value);
  EdgeInsets get right => EdgeInsets.only(right: value);
  EdgeInsets get top => EdgeInsets.only(top: value);
  EdgeInsets get bottom => EdgeInsets.only(bottom: value);
  EdgeInsets get all => EdgeInsets.all(value);
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: value);
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: value);
  EdgeInsets get symmetric => EdgeInsets.all(value);
}
