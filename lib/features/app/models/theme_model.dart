import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/theme/app_theme.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:json_theme/json_theme.dart';

part 'theme_model.freezed.dart';

@freezed
@singleton
@preResolve
class ThemeModel with _$ThemeModel {
  factory ThemeModel({
    required ThemeMode mode,
    required ThemeData light,
    required ThemeData dark,
  }) = _ThemeModel;

  factory ThemeModel.initial() => ThemeModel(
        mode: ThemeMode.system,
        light: ThemeData.light(),
        dark: ThemeData.dark(),
      );

  ThemeModel._();

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    try {
      final mode = json['mode'] as int;
      final light = json['light'] as Map<String, dynamic>;
      final dark = json['dark'] as Map<String, dynamic>;

      return ThemeModel(
        mode: ThemeMode.values.elementAt(mode),
        light: ThemeDecoder.decodeThemeData(light, validate: false)!,
        dark: ThemeDecoder.decodeThemeData(dark, validate: false)!,
      );
    } catch (e) {
      return ThemeModel.initial();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.index,
      'light': ThemeEncoder.encodeThemeData(light),
      'dark': ThemeEncoder.encodeThemeData(dark),
    };
  }

  @factoryMethod
  static Future<ThemeModel> create() async {
    return ThemeModel(
      mode: ThemeMode.system,
      light: await createTheme(brightness: Brightness.light),
      dark: await createTheme(brightness: Brightness.dark),
    );
  }
}
