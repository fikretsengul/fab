import 'package:deps/design/design.dart';
import 'package:deps/packages/flex_color_scheme.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/material.dart';

import '../others/serializer/json_color_type_serializer.dart';

part 'theme_colors.freezed.dart';
part 'theme_colors.g.dart';

@freezed
class ThemeColors with _$ThemeColors {
  factory ThemeColors({
    @JsonColorTypeSerializer() required Color primary,
    @JsonColorTypeSerializer() Color? secondary,
    @JsonColorTypeSerializer() Color? tertiary,
  }) = _ThemeColors;

  const ThemeColors._();

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

  factory ThemeColors.fromJson(Map<String, dynamic> json) => _$ThemeColorsFromJson(json);

  factory ThemeColors.inital() => ThemeSettings.defaultTheme;

  FlexSchemeColor get toFlexSchemeColor =>
      FlexSchemeColor.from(primary: primary, secondary: secondary, tertiary: tertiary);
}
