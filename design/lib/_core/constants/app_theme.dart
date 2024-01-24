// ignore_for_file: unused_element, unused_field

import 'package:deps/packages/theme_tailor_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_typography.dart';

part 'app_theme.tailor.dart';

const String fontName = 'VisueltPro';

@Tailor(
  themes: ['light', 'dark'],
  themeGetter: ThemeGetter.onBuildContextProps,
  generateStaticGetters: true,
)
class _$AppTheme {
  /// Colors
  static const List<Color> primary = [Colors.yellow, Colors.yellow];
  static const List<Color> background = [Colors.white, Colors.black];
  static const List<Color> onBackground = [Colors.black, Colors.white];
  static const List<Color> surface = [Color.fromARGB(255, 229, 229, 234), Color.fromARGB(255, 44, 44, 46)];
  static const List<Color> placeholder = [Color.fromARGB(255, 242, 242, 247), Color.fromARGB(255, 28, 28, 30)];
  static const List<Color> appBarExpanded = [Colors.white, Colors.black];
  static const List<Color> appBarCollapsed = [Color.fromARGB(255, 241, 241, 241), Color.fromARGB(255, 14, 14, 14)];

  /// Components
  static final List<TextStyle> appBarTitleNActions = [
    AppTypography.headline.apply(color: Colors.black),
    AppTypography.headline.apply(color: Colors.white),
  ];
  static final List<TextStyle> appBarLargeTitle = [
    AppTypography.largeTitle.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
    AppTypography.largeTitle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
  ];

  /// Texts
  static final List<TextStyle> largeTitle = [
    AppTypography.largeTitle.apply(color: Colors.black),
    AppTypography.largeTitle.apply(color: Colors.white),
  ];
  static final List<TextStyle> title1 = [
    AppTypography.title1.apply(color: Colors.black),
    AppTypography.title1.apply(color: Colors.white),
  ];
  static final List<TextStyle> title2 = [
    AppTypography.title2.apply(color: Colors.black),
    AppTypography.title2.apply(color: Colors.white),
  ];
  static final List<TextStyle> title3 = [
    AppTypography.title3.apply(color: Colors.black),
    AppTypography.title3.apply(color: Colors.white),
  ];
  static final List<TextStyle> headline = [
    AppTypography.headline.apply(color: Colors.black),
    AppTypography.headline.apply(color: Colors.white),
  ];
  static final List<TextStyle> body = [
    AppTypography.body.apply(color: Colors.black),
    AppTypography.body.apply(color: Colors.white),
  ];
  static final List<TextStyle> callout = [
    AppTypography.callout.apply(color: Colors.black),
    AppTypography.callout.apply(color: Colors.white),
  ];
  static final List<TextStyle> subhead = [
    AppTypography.subhead.apply(color: Colors.black),
    AppTypography.subhead.apply(color: Colors.white),
  ];
  static final List<TextStyle> footnote = [
    AppTypography.footnote.apply(color: Colors.black),
    AppTypography.footnote.apply(color: Colors.white),
  ];
  static final List<TextStyle> caption1 = [
    AppTypography.caption1.apply(color: Colors.black),
    AppTypography.caption1.apply(color: Colors.white),
  ];
  static final List<TextStyle> caption2 = [
    AppTypography.caption2.apply(color: Colors.black),
    AppTypography.caption2.apply(color: Colors.white),
  ];
}
