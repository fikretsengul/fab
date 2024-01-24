import 'package:flutter/material.dart';

ThemeData darkThemeData = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: const ColorScheme.dark(
    primary: Colors.yellow,
  ),
  textTheme: Typography.whiteCupertino,
  iconTheme: const IconThemeData(
    color: Colors.yellow,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.yellow,
    textTheme: ButtonTextTheme.primary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.yellow,
    ),
  ),
/*   cupertinoOverrideTheme: CupertinoThemeData(
    brightness: Brightness.dark,
    barBackgroundColor: const Color.fromARGB(255, 14, 14, 14),
    primaryColor: Colors.yellow,
    textTheme: CupertinoTextThemeData(
      primaryColor: Colors.yellow,
      textStyle: const CupertinoTextThemeData().textStyle.copyWith(
            color: CupertinoColors.white,
            inherit: false,
          ),
    ),
  ), */
);
