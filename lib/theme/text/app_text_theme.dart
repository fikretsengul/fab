import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_text_theme.freezed.dart';

typedef MaterialTextTheme = TextTheme;

@freezed
class AppTextTheme with _$AppTextTheme {
  factory AppTextTheme({
    required TextStyle displayLarge,
    required TextStyle displayMedium,
    required TextStyle displaySmall,
    required TextStyle headlineLarge,
    required TextStyle headlineMedium,
    required TextStyle headlineSmall,
    required TextStyle titleLarge,
    required TextStyle titleMedium,
    required TextStyle titleSmall,
    required TextStyle bodyLarge,
    required TextStyle bodyMedium,
    required TextStyle bodySmall,
    required TextStyle labelLarge,
    required TextStyle labelMedium,
    required TextStyle labelSmall,
  }) = _AppTextTheme;

  const AppTextTheme._();

  MaterialTextTheme get materialTextTheme => MaterialTextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
