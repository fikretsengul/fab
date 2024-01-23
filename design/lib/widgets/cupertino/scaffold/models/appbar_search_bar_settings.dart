import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar_action_settings.dart';

class AppBarSearchBarSettings {
  AppBarSearchBarSettings({
    this.resultColor,
    this.backgroundColor = CupertinoColors.tertiarySystemFill,
    this.cancelButtonText = 'Cancel',
    this.placeholderText = 'Search',
    this.enabled = false,
    this.scrollBehavior = SearchBarScrollBehavior.floated,
    this.animationBehavior = SearchBarAnimationBehavior.top,
    this.resultBehavior = SearchBarResultBehavior.visibleOnFocus,
    this.animationDuration = const Duration(milliseconds: 200),
    this.placeholderTextStyle = const TextStyle(
      color: CupertinoColors.systemGrey,
    ),
    this.cancelTextStyle = const TextStyle(color: CupertinoColors.systemBlue),
    this.prefixIcon = const Icon(
      CupertinoIcons.search,
      color: CupertinoColors.systemGrey,
    ),
    this.actions = const <AppBarActionSettings>[],
    this.height = 36,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
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
  });

  final List<AppBarActionSettings> actions;
  final SearchBarAnimationBehavior animationBehavior;
  final Duration animationDuration;
  final Color backgroundColor;
  final String cancelButtonText;
  final TextStyle cancelTextStyle;
  final bool enabled;
  double height;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocused;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsets padding;
  final String placeholderText;
  final TextStyle placeholderTextStyle;
  final Icon prefixIcon;
  final SearchBarResultBehavior resultBehavior;
  final Color? resultColor;
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

enum AppBarActionSettingsBehavior {
  alwaysVisible,
  visibleOnFocus,
  visibleOnUnFocus,
}
