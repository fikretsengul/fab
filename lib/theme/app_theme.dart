import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/theme/color/app_color_scheme.dart';
import 'package:flutter_advanced_boilerplate/theme/text/app_text_theme.dart';
import 'package:flutter_advanced_boilerplate/theme/text/app_typography.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/palette.dart';

Future<ThemeData> createTheme({
  Color? color,
  required Brightness brightness,
}) async {
  final colorScheme = _getColorScheme(color: color, brightness: brightness);
  final dynamicColorScheme = await _getDynamicColors(brightness: brightness);
  final appColorScheme = _getAppColorScheme(
    color: color,
    colorScheme: colorScheme,
    dynamicColorScheme: dynamicColorScheme,
    brightness: brightness,
  );

  final appTypography = AppTypography.create(fontFamily: Constants.defaultFontFamily);
  final textTheme = _getTextTheme(appTypography: appTypography, brightness: brightness);

  final primaryColor = ElevationOverlay.colorWithOverlay(appColorScheme.surface, appColorScheme.primary, 3);
  final customOnPrimaryColor = appColorScheme.primary.withOpacity(0.5);

  return ThemeData(
    textTheme: textTheme.materialTextTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: appColorScheme.materialColorScheme,
    brightness: appColorScheme.brightness,
    typography: appTypography.materialTypography,
    useMaterial3: true,
    toggleableActiveColor: customOnPrimaryColor,
    appBarTheme: AppBarTheme(
      elevation: Constants.defaultElevation,
      systemOverlayStyle: createOverlayStyle(
        brightness: brightness,
        primaryColor: primaryColor,
      ),
    ),
    scaffoldBackgroundColor: appColorScheme.surface,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: Constants.defaultElevation,
      highlightElevation: Constants.defaultElevation,
    ),
    iconTheme: IconThemeData(
      color: appColorScheme.primary,
    ),
    cardTheme: CardTheme(
      elevation: Constants.defaultElevation,
      color: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            Constants.defaultBorderRadius,
          ),
        ),
      ),
    ),
  );
}

SystemUiOverlayStyle createOverlayStyle({required Brightness brightness, required Color primaryColor}) {
  final isDark = brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    systemNavigationBarColor: primaryColor,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: brightness,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}

Future<ColorScheme?> _getDynamicColors({required Brightness brightness}) async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();

    return corePalette?.toColorScheme(brightness: brightness);
  } on PlatformException {
    return Future.value();
  }
}

ColorScheme _getColorScheme({
  Color? color,
  required Brightness brightness,
}) {
  return ColorScheme.fromSeed(
    seedColor: color ?? Constants.defaultThemeColor,
    brightness: brightness,
  );
}

AppColorScheme _getAppColorScheme({
  Color? color,
  required ColorScheme colorScheme,
  ColorScheme? dynamicColorScheme,
  required Brightness brightness,
}) {
  final isDark = brightness == Brightness.dark;

  return AppColorScheme.fromMaterialColorScheme(
    color != null
        ? colorScheme
        : Constants.tryToGetColorPaletteFromWallpaper
            ? dynamicColorScheme ?? colorScheme
            : colorScheme,
    disabled: Palette.grey,
    onDisabled: isDark ? Palette.white : Palette.black,
  );
}

AppTextTheme _getTextTheme({
  required AppTypography appTypography,
  required Brightness brightness,
}) {
  return brightness == Brightness.dark ? appTypography.white : appTypography.black;
}
