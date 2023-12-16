// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// Extension on `Color` to provide additional utility methods.
extension ColorExt on Color {
  /// Converts `Color` to ARGB format with an alpha value of 0.
  ///
  /// This method returns a new `Color` object with the same red, green, and blue values,
  /// but with an alpha value set to 0, effectively making it fully transparent.
  Color get toARGB => Color.fromARGB(0, red, green, blue);

  /// Converts `Color` to a hexadecimal string representation.
  ///
  /// This method returns a string in the format of "#RRGGBBAA", representing the
  /// red, green, blue, and alpha values of the color. The string is uppercased and
  /// left-padded with zeros if necessary to ensure an 8-character length.
  String get toHex => "#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
