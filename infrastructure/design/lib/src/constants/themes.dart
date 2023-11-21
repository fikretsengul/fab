import 'package:flutter/material.dart';

import 'flex_themes/light_theme.dart';

@immutable
final class Themes {
  const Themes._();

  static ThemeData light() => flexLightTheme();
  static ThemeData dark() => ThemeData.dark();
}
