import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/theme/color/app_color_scheme.dart';
import 'package:flutter_advanced_boilerplate/theme/text/app_text_theme.dart';
import 'package:flutter_advanced_boilerplate/theme/text/app_typography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_model.freezed.dart';

typedef MaterialThemeData = ThemeData;

@freezed
class ThemeModel with _$ThemeModel {
  factory ThemeModel({
    required AppColorScheme colorScheme,
    required AppTypography typography,
    required AppTextTheme textTheme,
    required MaterialThemeData materialThemeData,
  }) = _ThemeModel;
}
