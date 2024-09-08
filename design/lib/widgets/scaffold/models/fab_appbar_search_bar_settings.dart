import 'package:deps/features/features.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import 'fab_appbar_action_settings.dart';
import 'fab_appbar_toolbar_settings.dart';

class FabAppBarSearchBarSettings {
  FabAppBarSearchBarSettings({
    Color? backgroundColor,
    Widget? prefixIcon,
    this.cancelButtonText = 'cancel',
    this.placeholderText = 'search',
    this.toolbar,
    this.enabled = false,
    this.scrollBehavior = SearchBarScrollBehavior.floated,
    this.animationBehavior = SearchBarAnimationBehavior.top,
    this.resultBehavior = SearchBarResultBehavior.visibleOnFocus,
    this.animationDuration = const Duration(milliseconds: 200),
    this.placeholderTextStyle,
    this.actions = const <FabAppBarActionSettings>[],
    this.height = 36,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.searchResult = const Text(
      '.',
      style: TextStyle(
        color: Colors.transparent,
      ),
    ),
    this.textStyle = const TextStyle(),
    this.onChanged,
    this.onSubmitted,
    this.onFocused,
    this.searchController,
    this.searchFocusNode,
  })  : backgroundColor = backgroundColor ?? $.theme.backgroundColor,
        prefixIcon = prefixIcon ??
            Icon(
              UIcons.boldRounded.search,
              color: $.theme.onBackgroundColor,
              size: 16,
            ) {
    toolbar = toolbar ?? FabAppBarToolbarSettings();

    if (!toolbar!.enabled) {
      toolbar!.height = 0;
    }
  }

  FabAppBarToolbarSettings? toolbar;
  final BorderRadius borderRadius;
  final Widget prefixIcon;
  final List<FabAppBarActionSettings> actions;
  final SearchBarAnimationBehavior animationBehavior;
  final Duration animationDuration;
  final Color backgroundColor;
  final String cancelButtonText;
  final bool enabled;
  double height;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocused;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsets padding;
  final String placeholderText;
  final TextStyle? placeholderTextStyle;
  final SearchBarResultBehavior resultBehavior;
  final SearchBarScrollBehavior scrollBehavior;
  TextEditingController? searchController;
  FocusNode? searchFocusNode;
  final Widget searchResult;
  final TextStyle textStyle;
}

class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader({
    required this.height,
    required this.child,
    super.key,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}

enum SearchBarScrollBehavior {
  pinned,
  floated,
}

enum SearchBarAnimationBehavior {
  top,
  steady,
}

enum SearchBarResultBehavior {
  visibleOnFocus,
  visibleOnInput,
  neverVisible,
}

enum FabAppBarActionSettingsBehavior {
  alwaysVisible,
  visibleOnFocus,
  visibleOnUnFocus,
}
