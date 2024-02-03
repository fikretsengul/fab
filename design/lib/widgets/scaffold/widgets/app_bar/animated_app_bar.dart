import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../_core/constants/app_theme.dart';
import '../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../models/fab_appbar_search_bar_settings.dart';
import '../../models/fab_appbar_settings.dart';
import '../../utils/helpers.dart';
import '../../utils/measures.dart';
import '../../utils/store.dart';
import 'app_bar_widget.dart';

class AnimatedAppBar extends StatelessWidget {
  const AnimatedAppBar({
    required this.animationController,
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
    required this.topPadding,
    required this.fullAppBarHeight,
    required this.focussedToolbar,
    required this.isCollapsed,
    required this.shouldTransiteBetweenRoutes,
    required this.color,
    this.brightness,
    super.key,
  });

  final AnimationController animationController;
  final Color color;
  final FabAppBarSettings appBar;
  final Brightness? brightness;
  final NavigationBarStaticComponents components;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final double focussedToolbar;
  final double fullAppBarHeight;
  final bool isCollapsed;
  final NavigationBarStaticComponentsKeys keys;
  final double largeTitleHeight;
  final Measures measures;
  final double opacity;
  final double scaleTitle;
  final double searchBarHeight;
  final bool shouldTransiteBetweenRoutes;
  final double titleOpacity;
  final double topPadding;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store.searchBarAnimationStatus,
      builder: (_, animationStatus, __) {
        return AnimatedPositioned(
          duration:
              animationStatus == SearchBarAnimationStatus.paused ? Duration.zero : measures.searchBarAnimationDuration,
          top: 0,
          left: 0,
          right: 0,
          height: _store.searchBarHasFocus.value
              ? (appBar.searchBar!.animationBehavior == SearchBarAnimationBehavior.top
                  ? focussedToolbar
                  : fullAppBarHeight)
              : fullAppBarHeight,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return DecoratedBox(
                decoration: defaultBorder(animationController.value),
                child: wrapWithBackground(
                  brightness: brightness,
                  hasBackgroundBlur: appBar.hasBackgroundBlur,
                  backgroundColor: color,
                  child: Builder(
                    builder: (context) {
                      final Widget appBarWidget = AppBarWidget(
                        animationStatus: animationStatus,
                        measures: measures,
                        appBar: appBar,
                        largeTitleHeight: largeTitleHeight,
                        scaleTitle: scaleTitle,
                        components: components,
                        searchBarHeight: searchBarHeight,
                        opacity: opacity,
                        titleOpacity: titleOpacity,
                        editingController: editingController,
                        focusNode: focusNode,
                        keys: keys,
                      );

                      if (!shouldTransiteBetweenRoutes || !isTransitionable(context)) {
                        return appBarWidget;
                      }

                      return Hero(
                        tag: HeroTag(Navigator.of(context)),
                        createRectTween: linearTranslateWithLargestRectSizeTween,
                        flightShuttleBuilder: (_, animation, flightDirection, fromHeroContext, toHeroContext) {
                          animation.addStatusListener((status) {
                            if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
                              _store.isInHero.value = false;
                            } else {
                              _store.isInHero.value = true;
                            }
                          });

                          return navBarHeroFlightShuttleBuilder(
                            animation,
                            flightDirection,
                            fromHeroContext,
                            toHeroContext,
                          );
                        },
                        placeholderBuilder: (_, __, child) {
                          return navBarHeroLaunchPadBuilder(child);
                        },
                        transitionOnUserGestures: true,
                        child: OverridenTransitionableNavigationBar(
                          componentsKeys: keys,
                          backgroundColor: color,
                          backButtonTextStyle: context.appTheme.appBarTitleNActionsStyle.copyWith(inherit: false),
                          titleTextStyle: defaultTitleTextStyle(context, appBar),
                          largeTitleTextStyle: appBar.largeTitle!.textStyle ??
                              context.appTheme.appBarLargeTitleStyle.copyWith(inherit: false),
                          border: null,
                          hasUserMiddle: isCollapsed,
                          largeExpanded: !isCollapsed && appBar.largeTitle!.enabled,
                          searchBarHasFocus: _store.searchBarHasFocus.value,
                          child: appBarWidget,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
