import 'dart:ui';

import 'package:deps/core/theming/theming.dart';

abstract class ThemeConstants {
  static final themes = [
    ThemeColors.custom(primary: const Color(0xFFBEFD73)),
    ThemeColors.custom(primary: const Color(0xFF77DD77)),
    ThemeColors.custom(primary: const Color(0xFFA0FFF0)),
    ThemeColors.custom(primary: const Color(0xFF7DD5FF)),
    ThemeColors.custom(primary: const Color(0xFFCA9BF7)),
    ThemeColors.custom(primary: const Color(0xFFFFACD8)),
    ThemeColors.custom(primary: const Color(0xFFFF6961)),
    ThemeColors.custom(primary: const Color(0xFFFFB677)),
    ThemeColors.custom(primary: const Color(0xFFFFF97E)),
  ];
  static final defaultTheme = themes.elementAt(2);
}
