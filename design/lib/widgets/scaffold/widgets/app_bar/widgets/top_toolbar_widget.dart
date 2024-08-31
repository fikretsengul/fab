import 'package:deps/design/design.dart';
import 'package:flutter/cupertino.dart' hide CupertinoNavigationBarBackButton;

import '../../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';

class TopToolbarWidget extends StatelessWidget {
  const TopToolbarWidget({
    required this.measures,
    required this.animationStatus,
    required this.appBarSettings,
    required this.components,
    required this.keys,
    super.key,
    this.backIcon,
    this.padding,
    this.middleVisible,
  });

  final Measures measures;
  final SearchBarAnimationStatus animationStatus;
  final FabAppBarSettings appBarSettings;
  final NavigationBarStaticComponentsKeys keys;
  final NavigationBarStaticComponents components;
  final bool? middleVisible;
  final Widget? backIcon;
  final EdgeInsetsGeometry? padding;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    Widget? middle = components.middle;

    if (middle != null) {
      middle = DefaultTextStyle(
        style: context.fabTheme.appBarTitleStyle.copyWith(inherit: false),
        child: Semantics(header: true, child: middle),
      );

      middle = middleVisible == null
          ? middle
          : AnimatedOpacity(
              opacity: middleVisible! ? 1.0 : 0.0,
              duration: Measures.instance().getStandartAnimDur,
              child: middle,
            );
    }

    Widget? leading = components.leading;
    final backChevron = backIcon != null
        ? KeyedSubtree(
            key: keys.backChevronKey,
            child: backIcon!,
          )
        : components.backChevron;
    final Widget? backLabel = components.backLabel;

    if (leading == null && backChevron != null && backLabel != null) {
      leading = CupertinoNavigationBarBackButton.assemble(
        backChevron,
        context.fabTheme.appBarActionsStyle.copyWith(inherit: false),
        backLabel,
      );
    }

    Widget paddedToolbar = NavigationToolbar(
      leading: leading,
      middle: middle,
      trailing: components.trailing,
      middleSpacing: 6,
    );

    if (padding != null) {
      paddedToolbar = Padding(
        padding: padding!,
        child: paddedToolbar,
      );
    }

    return AnimatedContainer(
      duration: animationStatus == SearchBarAnimationStatus.paused ? Duration.zero : measures.getSearchBarFocusAnimDur,
      height: _store.searchBarHasFocus.value
          ? (appBarSettings.searchBar.animationBehavior == SearchBarAnimationBehavior.top
              ? measures.getSafeZoneTopPadding
              : measures.getTopToolbarHeightWSafeZone)
          : measures.getTopToolbarHeightWSafeZone,
      child: AnimatedOpacity(
        duration:
            animationStatus == SearchBarAnimationStatus.paused ? Duration.zero : measures.getLargeTitleOpacityAnimDur,
        opacity: _store.searchBarHasFocus.value
            ? (appBarSettings.searchBar.animationBehavior == SearchBarAnimationBehavior.top ? 0 : 1)
            : 1,
        child: SafeArea(
          bottom: false,
          child: paddedToolbar,
        ),
      ),
    );
  }
}
