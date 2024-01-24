import 'package:flutter/material.dart';

import 'themes/dark_theme_data.dart';
import 'themes/light_theme_data.dart';

final class Themes {
  const Themes._();

  static ThemeData light() => lightThemeData;
  static ThemeData dark() => darkThemeData;
}
