import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter/material.dart';

import 'theme_colors.dart';

part 'custom_theme.freezed.dart';

@freezed
@singleton
@preResolve
class CustomTheme with _$CustomTheme {
  factory CustomTheme({
    required ThemeMode mode,
    required Brightness brightness,
    required Brightness textBrightness,
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
      textBrightness: ThemeData.estimateBrightnessForColor(colors.primary),
      colors: colors,
    );
  }

  factory CustomTheme.fromJson(Map<String, dynamic> json) {
    try {
      final mode = json['mode'] as int;
      final brightness = json['brightness'] as int;
      final textBrightness = json['textBrightness'] as int;
      final colors = json['colors'] as Map<String, dynamic>;

      return CustomTheme(
        mode: ThemeMode.values.elementAt(mode),
        brightness: Brightness.values.elementAt(brightness),
        textBrightness: Brightness.values.elementAt(textBrightness),
        colors: ThemeColors.fromJson(colors),
      );
    } catch (e) {
      return CustomTheme.initial();
    }
  }

  factory CustomTheme.initial() => CustomTheme(
        mode: ThemeMode.system,
        brightness: Brightness.light,
        textBrightness: ThemeData.estimateBrightnessForColor(
          ThemeColors.inital().primary,
        ),
        colors: ThemeColors.inital(),
      );

  bool get shouldInvertTextColor => textBrightness == Brightness.dark;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mode': mode.index,
      'brightness': brightness.index,
      'textBrightness': textBrightness.index,
      'colors': colors.toJson(),
    };
  }

  @factoryMethod
  static Future<CustomTheme> create() async {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

    return CustomTheme(
      mode: ThemeMode.system,
      brightness: brightness,
      textBrightness: ThemeData.estimateBrightnessForColor(
        ThemeColors.inital().primary,
      ),
      colors: ThemeColors.inital(),
    );
  }
}
