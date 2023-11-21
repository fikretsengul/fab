import 'package:flutter/material.dart';

import '../others/themes/light_theme.dart';

@immutable
final class Themes {
  const Themes._();

  static ThemeData light() => flexLightTheme();
  static ThemeData dark() => ThemeData.dark();
}
