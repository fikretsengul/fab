import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/material.dart';

import 'theme_colors.dart';

part 'custom_theme.freezed.dart';

@freezed
class CustomTheme with _$CustomTheme {
  factory CustomTheme({
    required ThemeMode mode,
    required Brightness brightness,
    required ThemeColors colors,
  }) = _CustomTheme;

  CustomTheme._();

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

  factory CustomTheme.initial() => CustomTheme(
        mode: ThemeMode.system,
        brightness: Brightness.light,
        colors: ThemeColors.inital(),
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mode': mode.index,
      'brightness': brightness.index,
      'colors': colors.toJson(),
    };
  }
}
