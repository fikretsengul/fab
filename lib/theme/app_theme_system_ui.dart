import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme_system_ui.freezed.dart';

enum AppThemeSystemUiType { surface, background, primary }

enum AppThemeType {
  system,
  user,
}

@freezed
class AppThemeSystemUi with _$AppThemeSystemUi {
  const factory AppThemeSystemUi(
    Brightness iconsBrightness,
    AppThemeSystemUiType type,
  ) = _AppThemeSystemUi;

  const AppThemeSystemUi._();

  factory AppThemeSystemUi.surface(Brightness status) => AppThemeSystemUi(status, AppThemeSystemUiType.surface);

  factory AppThemeSystemUi.background(Brightness status) => AppThemeSystemUi(status, AppThemeSystemUiType.background);

  factory AppThemeSystemUi.primary(Brightness status) => AppThemeSystemUi(status, AppThemeSystemUiType.primary);

  SystemUiOverlayStyle fromColors(ColorScheme colors) {
    final navigationBarColor = _getSystemNavigationBarColor(type, colors);
    final navigationBarIconBrightness = ThemeData.estimateBrightnessForColor(navigationBarColor);

    return SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarIconBrightness: navigationBarIconBrightness,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: iconsBrightness,
      statusBarBrightness: iconsBrightness,
    );
  }

  Color _getSystemNavigationBarColor(
    AppThemeSystemUiType type,
    ColorScheme colors,
  ) {
    switch (type) {
      case AppThemeSystemUiType.surface:
        return colors.surface;
      case AppThemeSystemUiType.background:
        return colors.background;
      case AppThemeSystemUiType.primary:
        return colors.primary;
    }
  }
}
