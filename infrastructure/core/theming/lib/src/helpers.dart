// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:flutter/material.dart';

import 'model/custom_theme.dart';

/// Creates a `ThemeData` object based on the provided `CustomTheme` settings.
///
/// This function decides between a light or dark theme configuration based on the
/// brightness specified in the `CustomTheme`. It uses the `Themes` utility class
/// to generate the appropriate `ThemeData`.
///
/// [theme]: The `CustomTheme` instance containing the theme settings.
///
/// Returns a `ThemeData` object configured as per the `CustomTheme` settings.
ThemeData createTheme(CustomTheme theme) {
  return theme.brightness == Brightness.light
    ? Themes.lightTheme(theme)
    : Themes.darkTheme(theme);
}
