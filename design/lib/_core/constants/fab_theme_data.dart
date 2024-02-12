import 'package:flutter/material.dart';

import '../../widgets/_core/route/transition_builder.dart';
import 'fab_theme.dart';
import 'fab_typography.dart';

final appThemeLight = FabTheme(
  appBarCollapsedColor: Colors.white,
  appBarExpandedColor: Colors.white,
  appBarLargeTitleStyle: FabTypography.largeTitle.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
  appBarTitleStyle: FabTypography.title3.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
  appBarActionsStyle: FabTypography.headline.copyWith(color: Colors.black),
  backgroundColor: Colors.white,
  bodyStyle: FabTypography.body.apply(color: Colors.black),
  calloutStyle: FabTypography.callout.apply(color: Colors.black),
  caption1Style: FabTypography.caption1.apply(color: Colors.black),
  caption2Style: FabTypography.caption2.apply(color: Colors.black),
  footnoteStyle: FabTypography.footnote.apply(color: Colors.black),
  headlineStyle: FabTypography.headline.apply(color: Colors.black),
  largeTitleStyle: FabTypography.largeTitle.apply(color: Colors.black),
  onBackgroundColor: Colors.black,
  inactiveColor: const Color(0xFF999999),
  softInactiveColor: const Color.fromARGB(255, 229, 229, 234),
  primaryColor: Colors.black,
  onPrimaryColor: Colors.white,
  errorColor: Colors.red,
  borderColor: const Color(0xFFB2B2B2),
  subheadStyle: FabTypography.subhead.apply(color: Colors.black),
  surfaceColor: const Color(0xFFE5E5EA),
  title1Style: FabTypography.title1.apply(color: Colors.black),
  title2Style: FabTypography.title2.apply(color: Colors.black),
  title3Style: FabTypography.title3.apply(color: Colors.black),
);

final appThemeDark = FabTheme(
  appBarCollapsedColor: Colors.black,
  appBarExpandedColor: Colors.black,
  borderColor: const Color.fromARGB(255, 140, 140, 140),
  appBarLargeTitleStyle: FabTypography.largeTitle.copyWith(fontWeight: FontWeight.w700),
  appBarTitleStyle: FabTypography.title3.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
  appBarActionsStyle: FabTypography.headline.copyWith(color: Colors.white),
  backgroundColor: Colors.black,
  bodyStyle: FabTypography.body.apply(color: Colors.white),
  calloutStyle: FabTypography.callout.apply(color: Colors.white),
  caption1Style: FabTypography.caption1.apply(color: Colors.white),
  caption2Style: FabTypography.caption2.apply(color: Colors.white),
  footnoteStyle: FabTypography.footnote.apply(color: Colors.white),
  headlineStyle: FabTypography.headline.apply(color: Colors.white),
  largeTitleStyle: FabTypography.largeTitle.apply(color: Colors.white),
  onBackgroundColor: Colors.white,
  inactiveColor: const Color(0xFF757575),
  softInactiveColor: const Color.fromARGB(255, 44, 44, 46),
  primaryColor: Colors.white,
  onPrimaryColor: Colors.black,
  errorColor: Colors.red,
  subheadStyle: FabTypography.subhead.apply(color: Colors.white),
  surfaceColor: const Color(0xFF171717),
  //const Color.fromARGB(255, 44, 44, 46),
  title1Style: FabTypography.title1.apply(color: Colors.white),
  title2Style: FabTypography.title2.apply(color: Colors.white),
  title3Style: FabTypography.title3.apply(color: Colors.white),
);

final appThemeDataLight = ThemeData(
  brightness: Brightness.light,
  extensions: [appThemeLight],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: PopScopeAwareCupertinoPageTransitionBuilder(),
    },
  ),
);

final appThemeDataDark = ThemeData(
  brightness: Brightness.dark,
  extensions: [appThemeDark],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: PopScopeAwareCupertinoPageTransitionBuilder(),
    },
  ),
);
