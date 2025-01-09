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

ThemeData getCurrentTheme(BuildContext context) {
  return Theme.of(context);
}

Color getPrimaryColor(BuildContext context) {
  return getTheme(context).primary;
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
  return theme.copyWith(
    appBarTheme: theme.appBarTheme.copyWith(
      titleTextStyle:
          theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 25),
        ),
        textStyle: WidgetStatePropertyAll(
          theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: theme.outlinedButtonTheme.style?.copyWith(
        minimumSize: const WidgetStatePropertyAll(Size(200, 40)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 25),
        ),
        textStyle: WidgetStatePropertyAll(
          theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w800, fontSize: 15),
        ),
      ),
    ),
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
