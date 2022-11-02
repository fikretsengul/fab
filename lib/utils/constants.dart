import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/palette.dart';

@immutable
abstract class Constants {
  const Constants._();

  /// General configuration.
  static const appTitle = 'Flutter Advanced Boilerplate';

  /// Theme configuration.

  // This setting is only for android 12, on iOS appColor will be used as default theme color.
  static const tryToGetColorPaletteFromWallpaper = false;
  static const disableSplashEffectOnUI = true;
  static const defaultThemeColor = Palette.blue;
  static const defaultFontFamily = 'Nunito';
  static const double defaultElevation = 0;
  static const double defaultBorderRadius = 24;

  // Padding configuration.
  static const double paddingXS = 8;
  static const double paddingS = 12;
  static const double paddingM = 16;
  static const double paddingL = 20;
  static const double paddingXL = 24;
  static const double paddingXXL = 36;

  /// API configuration.
  static const maxItemToBeFetchedAtOneTime = 5;
}
