// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/core/theming/theming.dart';
import 'package:flutter/material.dart';

/// Defines the style of the FabButton.
enum ButtonType { primary, classic }

class ThemeSettings {
  static final themes = [
    ThemeColors.custom(primary: const Color(0xFFBEFD73)),
    ThemeColors.custom(primary: const Color(0xFF77DD77)),
    ThemeColors.custom(primary: const Color(0xFFA0FFF0)),
    ThemeColors.custom(primary: const Color(0xFF7DD5FF)),
    ThemeColors.custom(primary: const Color(0xFFCA9BF7)),
    ThemeColors.custom(primary: const Color(0xFFFFACD8)),
    ThemeColors.custom(primary: const Color(0xFFFF6961)),
    ThemeColors.custom(primary: const Color(0xFFFFB677)),
    ThemeColors.custom(primary: const Color(0xFFFFF97E)),
  ];

  static final defaultTheme = themes.elementAt(6);
  static const borderRadius = BorderRadius.all(Radius.circular(16));
  static const borderWidth = 2.0;
  static const shadowBlurRadius = 0.0;
  static const offset = Offset(4, 4);
  static const shadowBlurStyle = BlurStyle.normal;
}
