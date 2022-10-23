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
  static const defaultThemeColor = Palette.blue;
  static const defaultFontFamily = 'Nunito';

  /// API configuration.
  static const maxItemToBeFetchedAtOneTime = 5;
}
