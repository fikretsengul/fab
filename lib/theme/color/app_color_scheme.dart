import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_color_scheme.freezed.dart';

typedef MaterialColorScheme = ColorScheme;

@freezed
class AppColorScheme with _$AppColorScheme {
  factory AppColorScheme({
    required Brightness brightness,
    required Color primary,
    required Color onPrimary,
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color secondary,
    required Color onSecondary,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required Color tertiary,
    required Color onTertiary,
    required Color tertiaryContainer,
    required Color onTertiaryContainer,
    required Color error,
    required Color onError,
    required Color errorContainer,
    required Color onErrorContainer,
    required Color background,
    required Color onBackground,
    required Color surface,
    required Color onSurface,
    required Color surfaceVariant,
    required Color onSurfaceVariant,
    required Color outline,
    required Color shadow,
    required Color inverseSurface,
    required Color onInverseSurface,
    required Color inversePrimary,
    required Color disabled,
    required Color onDisabled,
  }) = _AppColorScheme;

  factory AppColorScheme.fromMaterialColorScheme(
    ColorScheme colorScheme, {
    required Color disabled,
    required Color onDisabled,
  }) =>
      AppColorScheme(
        brightness: colorScheme.brightness,
        primary: colorScheme.primary,
        onPrimary: colorScheme.onPrimary,
        primaryContainer: colorScheme.primaryContainer,
        onPrimaryContainer: colorScheme.onPrimaryContainer,
        secondary: colorScheme.secondary,
        onSecondary: colorScheme.onSecondary,
        secondaryContainer: colorScheme.secondaryContainer,
        onSecondaryContainer: colorScheme.onSecondaryContainer,
        tertiary: colorScheme.tertiary,
        onTertiary: colorScheme.onTertiary,
        tertiaryContainer: colorScheme.tertiaryContainer,
        onTertiaryContainer: colorScheme.onTertiaryContainer,
        error: colorScheme.error,
        onError: colorScheme.onError,
        errorContainer: colorScheme.errorContainer,
        onErrorContainer: colorScheme.onErrorContainer,
        background: colorScheme.background,
        onBackground: colorScheme.onBackground,
        surface: colorScheme.surface,
        onSurface: colorScheme.onSurface,
        surfaceVariant: colorScheme.surfaceVariant,
        onSurfaceVariant: colorScheme.onSurfaceVariant,
        outline: colorScheme.outline,
        shadow: colorScheme.shadow,
        inverseSurface: colorScheme.inverseSurface,
        onInverseSurface: colorScheme.onInverseSurface,
        inversePrimary: colorScheme.inversePrimary,
        disabled: disabled,
        onDisabled: onDisabled,
      );

  const AppColorScheme._();

  MaterialColorScheme get materialColorScheme => MaterialColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        surfaceVariant: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        shadow: shadow,
        inverseSurface: inverseSurface,
        onInverseSurface: onInverseSurface,
        inversePrimary: inversePrimary,
      );
}
