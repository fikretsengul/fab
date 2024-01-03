import 'package:flutter/material.dart';

import 'themes/flex_dark_theme_data.dart';
import 'themes/flex_light_theme_data.dart';

@immutable
final class Themes {
  const Themes._();

  static ThemeData light() => flexLightThemeData;
  static ThemeData dark() => flexDarkThemeData;
}
