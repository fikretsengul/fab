// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

@immutable
final class Radiuses {
  const Radiuses();

  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
}

extension RadiusesExtension on double {
  BorderRadius circularBorder() => BorderRadius.all(Radius.circular(this));
}
