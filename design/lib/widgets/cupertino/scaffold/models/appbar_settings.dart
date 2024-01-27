import 'package:flutter/cupertino.dart';

import 'appbar_bottom_settings.dart';
import 'appbar_large_title_settings.dart';
import 'appbar_search_bar_settings.dart';

class AppBarSettings {
  AppBarSettings({
    this.title,
    this.actions = const [],
    this.height = kMinInteractiveDimensionCupertino,
    this.leadingWidth,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.titleSpacing = 16,
    this.previousPageTitle = 'Back',
    this.alwaysShowTitle = false,
    this.searchBar,
    this.largeTitle,
    this.bottom,
    this.hasBackgroundBlur = false,
    this.backgroundColor,
    this.border,
    this.shadowColor,
  }) {
    searchBar = searchBar ?? AppBarSearchBarSettings();
    largeTitle = largeTitle ?? AppBarLargeTitleSettings();
    bottom = bottom ?? AppBarBottomSettings();

    if (!searchBar!.enabled) {
      searchBar!.height = 0;
    }
    if (!largeTitle!.enabled) {
      largeTitle!.height = 0;
    }
    if (!bottom!.enabled) {
      bottom!.height = 0;
    }

    title ??= Text(largeTitle!.largeTitle);
  }

  final List<Widget> actions;
  final bool alwaysShowTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  Border? border;
  AppBarBottomSettings? bottom;
  final bool hasBackgroundBlur;
  final double height;
  AppBarLargeTitleSettings? largeTitle;
  final Widget? leading;
  final double? leadingWidth;
  final String previousPageTitle;
  AppBarSearchBarSettings? searchBar;
  final Color? shadowColor;
  Widget? title;
  final double titleSpacing;
}
