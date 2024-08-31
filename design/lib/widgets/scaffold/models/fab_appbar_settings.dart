import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fab_appbar_large_title_settings.dart';
import 'fab_appbar_search_bar_settings.dart';
import 'fab_appbar_toolbar_settings.dart';

class FabAppBarSettings {
  FabAppBarSettings({
    this.title,
    this.actions = const [],
    this.height = kMinInteractiveDimensionCupertino,
    this.leadingWidth,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.titleSpacing = 16,
    this.previousPageTitle = 'back',
    this.alwaysShowTitle = false,
    this.hasBackgroundBlur = false,
    this.backgroundColor,
    this.border,
    this.shadowColor,
    FabAppBarSearchBarSettings? searchBar,
    FabAppBarLargeTitleSettings? largeTitle,
    FabAppBarToolbarSettings? toolbar,
    Widget? backIcon,
  })  : searchBar = searchBar ?? FabAppBarSearchBarSettings(),
        largeTitle = largeTitle ?? FabAppBarLargeTitleSettings(),
        toolbar = toolbar ?? FabAppBarToolbarSettings(),
        backIcon = Padding(
          padding: const EdgeInsets.only(bottom: 3.5),
          child: backIcon ??
              Icon(
                UIcons.boldRounded.angle_small_left,
                color: Colors.black,
                size: 24,
              ),
        ) {
    if (!searchBar!.enabled) {
      searchBar.height = 0;
    }

    if (!largeTitle!.enabled) {
      largeTitle.height = 0;
    }

    if (!toolbar!.enabled) {
      toolbar.height = 0;
    }

    title ??= Text(largeTitle.text);
  }

  Widget backIcon;
  final List<Widget> actions;
  final bool alwaysShowTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  Border? border;
  FabAppBarToolbarSettings toolbar;
  final bool hasBackgroundBlur;
  final double height;
  FabAppBarLargeTitleSettings largeTitle;
  final Widget? leading;
  final double? leadingWidth;
  final String previousPageTitle;
  FabAppBarSearchBarSettings searchBar;
  final Color? shadowColor;
  Widget? title;
  final double titleSpacing;
}
