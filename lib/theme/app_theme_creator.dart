import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/theme_model.dart';
import 'package:flutter_advanced_boilerplate/theme/app_theme_system_ui.dart';
import 'package:flutter_advanced_boilerplate/theme/color/app_color_scheme.dart';
import 'package:flutter_advanced_boilerplate/theme/text/app_typography.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/palette.dart';

Future<ThemeModel> createAppTheme({bool isDark = false, Color? color}) async {
  final brightness = isDark ? Brightness.dark : Brightness.light;

  final colorScheme = ColorScheme.fromSeed(
    seedColor: color ?? Constants.defaultThemeColor,
    brightness: brightness,
  );
  final dynamicColorsScheme = await _getDynamicColors(brightness);

  final appColorScheme = AppColorScheme.fromMaterialColorScheme(
    color != null
        ? colorScheme
        : Constants.tryToGetColorPaletteFromWallpaper
            ? dynamicColorsScheme ?? colorScheme
            : colorScheme,
    disabled: Palette.grey,
    onDisabled: Palette.black,
  );

  final appTypography = AppTypography.create(fontFamily: Constants.defaultFontFamily);
  final textTheme = isDark ? appTypography.white : appTypography.black;

  final customOnPrimaryColor = appColorScheme.primary.withOpacity(0.5);

  final materialThemeData = MaterialThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: appColorScheme.materialColorScheme,
    brightness: appColorScheme.brightness,
    typography: appTypography.materialTypography,
    useMaterial3: true,
    toggleableActiveColor: customOnPrimaryColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: appColorScheme.brightness,
      ),
      elevation: 0,
    ),
    scaffoldBackgroundColor: appColorScheme.surface,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      highlightElevation: 0,
    ),
    splashFactory: NoSplash.splashFactory,
  );

  return ThemeModel(
    colorScheme: appColorScheme,
    typography: appTypography,
    textTheme: textTheme,
    materialThemeData: materialThemeData,
  );
}

SystemUiOverlayStyle getAppOverlayStyle({required bool isDark, required ColorScheme colorScheme}) {
  return AppThemeSystemUi(
    isDark ? Brightness.dark : Brightness.light,
    AppThemeSystemUiType.surface,
  ).fromColors(colorScheme);
}

Future<ColorScheme?> _getDynamicColors(Brightness brightness) async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();

    return corePalette?.toColorScheme(brightness: brightness);
  } on PlatformException {
    return Future.value();
  }
}
