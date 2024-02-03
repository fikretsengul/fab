// ignore_for_file: unused_element, unused_field

import 'package:deps/packages/theme_tailor_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_typography.dart';

part 'app_theme.tailor.dart';

@Tailor(
  themes: ['light', 'dark'],
  themeGetter: ThemeGetter.onBuildContext,
)
class _$AppTheme {
  /// Colors
  static const List<Color> primaryColor = [Colors.red, Colors.red];
  static const List<Color> backgroundColor = [Colors.white, Colors.black];
  static const List<Color> onBackgroundColor = [Colors.black, Colors.white];
  static const List<Color> surfaceColor = [Color.fromARGB(255, 229, 229, 234), Color.fromARGB(255, 44, 44, 46)];
  static const List<Color> placeholderColor = [Color.fromARGB(255, 142, 142, 147), Color.fromARGB(255, 142, 142, 147)];
  static const List<Color> appBarExpandedColor = [Colors.white, Colors.black];
  static const List<Color> appBarCollapsedColor = [Colors.white, Colors.black];

  /// Components
  static final List<TextStyle> appBarTitleNActionsStyle = [
    AppTypography.headline.apply(color: Colors.black),
    AppTypography.headline.apply(color: Colors.white),
  ];
  static final List<TextStyle> appBarLargeTitleStyle = [
    AppTypography.largeTitle.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
    AppTypography.largeTitle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
  ];

  /// Texts
  static final List<TextStyle> largeTitleStyle = [
    AppTypography.largeTitle.apply(color: Colors.black),
    AppTypography.largeTitle.apply(color: Colors.white),
  ];
  static final List<TextStyle> title1Style = [
    AppTypography.title1.apply(color: Colors.black),
    AppTypography.title1.apply(color: Colors.white),
  ];
  static final List<TextStyle> title2Style = [
    AppTypography.title2.apply(color: Colors.black),
    AppTypography.title2.apply(color: Colors.white),
  ];
  static final List<TextStyle> title3Style = [
    AppTypography.title3.apply(color: Colors.black),
    AppTypography.title3.apply(color: Colors.white),
  ];
  static final List<TextStyle> headlineStyle = [
    AppTypography.headline.apply(color: Colors.black),
    AppTypography.headline.apply(color: Colors.white),
  ];
  static final List<TextStyle> bodyStyle = [
    AppTypography.body.apply(color: Colors.black),
    AppTypography.body.apply(color: Colors.white),
  ];
  static final List<TextStyle> calloutStyle = [
    AppTypography.callout.apply(color: Colors.black),
    AppTypography.callout.apply(color: Colors.white),
  ];
  static final List<TextStyle> subheadStyle = [
    AppTypography.subhead.apply(color: Colors.black),
    AppTypography.subhead.apply(color: Colors.white),
  ];
  static final List<TextStyle> footnoteStyle = [
    AppTypography.footnote.apply(color: Colors.black),
    AppTypography.footnote.apply(color: Colors.white),
  ];
  static final List<TextStyle> caption1Style = [
    AppTypography.caption1.apply(color: Colors.black),
    AppTypography.caption1.apply(color: Colors.white),
  ];
  static final List<TextStyle> caption2Style = [
    AppTypography.caption2.apply(color: Colors.black),
    AppTypography.caption2.apply(color: Colors.white),
  ];
}
