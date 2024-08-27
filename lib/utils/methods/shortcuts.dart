import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double getSliverBarHeight(BuildContext context) {
  return getStatusBarHeight(context) + kToolbarHeight;
}

double getAppBarHeight() {
  return AppBar().preferredSize.height;
}

double getBottomBarHeight() {
  return kBottomNavigationBarHeight;
}

ColorScheme getTheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

ColorScheme getPrimaryContainer(BuildContext context) {
  return Theme.of(context).colorScheme;
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

Color getPrimaryColor(BuildContext context) {
  return ElevationOverlay.colorWithOverlay(
      getTheme(context).surface, getTheme(context).primary, 3);
}

Color getCustomOnPrimaryColor(BuildContext context) {
  return getTheme(context).primary.withOpacity(0.5);
/*   return ElevationOverlay.colorWithOverlay(
    getTheme(context).primary,
    getTheme(context).background,
    isDarkMode(context) ? 1000 : 500,
  ); */
}

String colorToHex(Color c) {
  return "#${(c.value.toRadixString(16))..padLeft(8, '0').toUpperCase()}";
}

Color hexToColor(String h) {
  return Color(int.parse(h, radix: 16));
}

LinearGradient colorsToGradient(List<Color> colors, {double opacity = 1}) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: colors.map((c) => c.withOpacity(opacity)).toList(),
  );
}

/// Generate app theme data with default values
ThemeData _generateThemeData(ThemeData theme) {
  final buttonStyle = ButtonStyle(
    elevation: WidgetStateProperty.all(0),
    shape: WidgetStatePropertyAll(
      theme.buttonTheme.shape as RoundedRectangleBorder,
    ),
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
  );

  return theme.copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: theme.elevatedButtonTheme.style?.copyWith(
            shape: WidgetStatePropertyAll(
              theme.buttonTheme.shape as RoundedRectangleBorder,
            ),
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
          ) ??
          buttonStyle,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: theme.outlinedButtonTheme.style?.copyWith(
            shape: WidgetStatePropertyAll(
              theme.buttonTheme.shape as RoundedRectangleBorder,
            ),
            elevation: WidgetStateProperty.all<double>(0),
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
          ) ??
          buttonStyle,
    ),
    appBarTheme: theme.appBarTheme,
  );
}

Future<ThemeData?> loadThemeData(String themePath) async {
  try {
    final themeStr = await rootBundle.loadString(themePath);
    final themeJson = json.decode(themeStr);
    final theme = ThemeDecoder.decodeThemeData(
      themeJson,
      validate: false,
    )!;
    return _generateThemeData(
      theme.copyWith(textTheme: theme.textTheme),
    );
  } catch (e) {
    return null;
  }
}
