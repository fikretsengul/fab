import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../overridens/overriden_transitionable_navigation_bar.dart';
import '../../models/appbar_search_bar_settings.dart';
import '../../models/appbar_settings.dart';
import '../../utils/measures.dart';
import '../../utils/store.dart';
import 'search_bar/search_bar_widget.dart';
import 'widgets/bottom_toolbar_widget.dart';
import 'widgets/large_title_widget.dart';
import 'widgets/persistent_nav_bar.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.animationStatus,
    required this.measures,
    required this.appBar,
    required this.largeTitleHeight,
    required this.scaleTitle,
    required this.components,
    required this.searchBarHeight,
    required this.opacity,
    required this.titleOpacity,
    required this.editingController,
    required this.focusNode,
    required this.keys,
    super.key,
  });

  final SearchBarAnimationStatus animationStatus;
  final AppBarSettings appBar;
  final NavigationBarStaticComponents components;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final NavigationBarStaticComponentsKeys keys;
  final double largeTitleHeight;
  final Measures measures;
  final double opacity;
  final double scaleTitle;
  final double searchBarHeight;
  final double titleOpacity;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration:
              animationStatus == SearchBarAnimationStatus.paused ? Duration.zero : measures.searchBarAnimationDuration,
          height: _store.searchBarHasFocus.value
              ? (appBar.searchBar!.animationBehavior == SearchBarAnimationBehavior.top
                  ? MediaQuery.paddingOf(context).top
                  : measures.primaryToolbarHeight + MediaQuery.paddingOf(context).top)
              : measures.primaryToolbarHeight + MediaQuery.paddingOf(context).top,
          child: AnimatedOpacity(
            duration: animationStatus == SearchBarAnimationStatus.paused
                ? Duration.zero
                : measures.titleOpacityAnimationDuration,
            opacity: _store.searchBarHasFocus.value
                ? (appBar.searchBar!.animationBehavior == SearchBarAnimationBehavior.top ? 0 : 1)
                : 1,
            child: PersistentNavigationBar(
              keys: keys,
              components: components,
              backIcon: appBar.backIcon,
              middleVisible: appBar.alwaysShowTitle ? null : titleOpacity != 0,
            ),
          ),
        ),
        const Spacer(),
        LargeTitleWidget(
          animationStatus: animationStatus,
          measures: measures,
          appBar: appBar,
          titleOpacity: titleOpacity,
          largeTitleHeight: largeTitleHeight,
          scaleTitle: scaleTitle,
          components: components,
        ),
        SearchBarWidget(
          searchBar: appBar.searchBar!,
          measures: measures,
          searchBarHeight: searchBarHeight,
          opacity: opacity,
          editingController: editingController,
          focusNode: focusNode,
          keys: keys,
        ),
        BottomToolbarWidget(
          measures: measures,
          appbarBottom: components.appbarBottom!,
          color: appBar.bottom!.color,
        ),
      ],
    );
  }
}
