// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/material.dart';

import 'theme_colors.dart';

part 'custom_theme.freezed.dart';

/// `CustomTheme` is an immutable class representing a custom theme configuration.
/// It uses the `freezed` package to provide a robust and comprehensive theming approach.
@freezed
class CustomTheme with _$CustomTheme {
  /// Constructs a `CustomTheme` with the given properties.
  ///
  /// [mode]: The `ThemeMode` for the theme, controlling the overall theme style.
  /// [brightness]: The `Brightness` for the theme, specifying the overall lightness or darkness.
  /// [colors]: The `ThemeColors` object containing color definitions for the theme.
  factory CustomTheme({
    required ThemeMode mode,
    required Brightness brightness,
    required ThemeColors colors,
  }) = _CustomTheme;

  CustomTheme._();

  /// Factory method to create a custom theme with specified properties.
  factory CustomTheme.custom({
    required ThemeMode mode,
    required Brightness brightness,
    required ThemeColors colors,
  }) {
    return CustomTheme(
      mode: mode,
      brightness: brightness,
      colors: colors,
    );
  }

  /// Creates a `CustomTheme` instance from JSON data.
  ///
  /// Tries to parse the JSON map into a `CustomTheme`. If it fails, returns an initial theme.
  factory CustomTheme.fromJson(Map<String, dynamic> json) {
    try {
      final mode = json['mode'] as int;
      final brightness = json['brightness'] as int;
      final colors = json['colors'] as Map<String, dynamic>;

      return CustomTheme(
        mode: ThemeMode.values.elementAt(mode),
        brightness: Brightness.values.elementAt(brightness),
        colors: ThemeColors.fromJson(colors),
      );
    } catch (e) {
      return CustomTheme.initial();
    }
  }

  /// Creates an initial `CustomTheme` with default settings.
  ///
  /// Returns a `CustomTheme` with system `ThemeMode`, light `Brightness`, and initial `ThemeColors`.
  factory CustomTheme.initial() => CustomTheme(
        mode: ThemeMode.system,
        brightness: Brightness.light,
        colors: ThemeColors.inital(),
      );

  /// Converts a `CustomTheme` instance to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mode': mode.index,
      'brightness': brightness.index,
      'colors': colors.toJson(),
    };
  }
}
