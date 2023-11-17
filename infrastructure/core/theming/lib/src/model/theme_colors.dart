// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/packages/flex_color_scheme.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/material.dart';

import '../serializer/json_color_type_serializer.dart';

part 'theme_colors.freezed.dart';
part 'theme_colors.g.dart';

/// `ThemeColors` is an immutable class representing the color scheme for a theme.
/// It uses the `freezed` package for immutability and `FlexColorScheme` for enhanced theming capabilities.
@freezed
class ThemeColors with _$ThemeColors {
  /// Constructs a `ThemeColors` instance with specified colors.
  ///
  /// [primary]: The primary color of the theme.
  /// [secondary]: Optional secondary color of the theme.
  /// [tertiary]: Optional tertiary color of the theme.
  factory ThemeColors({
    @JsonColorTypeSerializer() required Color primary,
    @JsonColorTypeSerializer() Color? secondary,
    @JsonColorTypeSerializer() Color? tertiary,
  }) = _ThemeColors;

  const ThemeColors._();

  /// Factory method for creating custom `ThemeColors`.
  factory ThemeColors.custom({
    required Color primary,
    Color? secondary,
    Color? tertiary,
  }) =>
      ThemeColors(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
      );

  /// Factory method to create a `ThemeColors` instance from JSON data.
  factory ThemeColors.fromJson(Map<String, dynamic> json) => _$ThemeColorsFromJson(json);

  /// Creates a default `ThemeColors` instance with pre-defined settings.
  factory ThemeColors.inital() => ThemeSettings.defaultTheme;

  /// Converts `ThemeColors` to `FlexSchemeColor` for use with `FlexColorScheme`.
  ///
  /// This method is useful for integrating the color scheme with `FlexColorScheme` theming.
  FlexSchemeColor get toFlexSchemeColor =>
      FlexSchemeColor.from(primary: primary, secondary: secondary, tertiary: tertiary);
}
