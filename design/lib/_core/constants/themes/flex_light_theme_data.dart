import 'package:deps/packages/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'text_theme.dart';

ThemeData flexLightThemeData = FlexThemeData.light(
  textTheme: textTheme,
  scheme: FlexScheme.aquaBlue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
);
