// ignore_for_file: unused_element, unused_field

import 'package:deps/packages/theme_tailor_annotation.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'fab_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class FabTheme extends ThemeExtension<FabTheme> with _$FabThemeTailorMixin {
  FabTheme({
    required this.borderColor,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.errorColor,
    required this.backgroundColor,
    required this.onBackgroundColor,
    required this.surfaceColor,
    required this.inactiveColor,
    required this.softInactiveColor,
    required this.appBarExpandedColor,
    required this.appBarCollapsedColor,
    required this.appBarTitleStyle,
    required this.appBarActionsStyle,
    required this.appBarLargeTitleStyle,
    required this.largeTitleStyle,
    required this.title1Style,
    required this.title2Style,
    required this.title3Style,
    required this.headlineStyle,
    required this.bodyStyle,
    required this.calloutStyle,
    required this.subheadStyle,
    required this.footnoteStyle,
    required this.caption1Style,
    required this.caption2Style,
  });

  @override
  final Color appBarCollapsedColor;

  @override
  final Color appBarExpandedColor;

  @override
  final TextStyle appBarLargeTitleStyle;

  @override
  final TextStyle appBarTitleStyle;

  @override
  final TextStyle appBarActionsStyle;

  @override
  final Color backgroundColor;

  @override
  final TextStyle bodyStyle;

  @override
  final Color borderColor;

  @override
  final TextStyle calloutStyle;

  @override
  final TextStyle caption1Style;

  @override
  final TextStyle caption2Style;

  @override
  final Color errorColor;

  @override
  final TextStyle footnoteStyle;

  @override
  final TextStyle headlineStyle;

  @override
  final TextStyle largeTitleStyle;

  @override
  final Color onBackgroundColor;

  @override
  final Color onPrimaryColor;

  @override
  final Color inactiveColor;

  @override
  final Color softInactiveColor;

  @override
  final Color primaryColor;

  @override
  final TextStyle subheadStyle;

  @override
  final Color surfaceColor;

  @override
  final TextStyle title1Style;

  @override
  final TextStyle title2Style;

  @override
  final TextStyle title3Style;
}
