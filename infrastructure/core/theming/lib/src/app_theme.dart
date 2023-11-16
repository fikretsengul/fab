import 'package:deps/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/custom_theme.dart';

ThemeData createTheme(CustomTheme theme) {
  return theme.brightness == Brightness.light ? Themes.lightTheme(theme) : Themes.darkTheme(theme);
}

SystemUiOverlayStyle getSystemUIOverlayStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    systemNavigationBarColor: Theme.of(context).colorScheme.onInverseSurface,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}
