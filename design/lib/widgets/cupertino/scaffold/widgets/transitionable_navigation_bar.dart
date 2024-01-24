// ignore_for_file: max_lines_for_file, avoid_returning_widgets, boolean_prefix

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

@immutable
class NavigationBarStaticComponents {
  NavigationBarStaticComponents({
    required NavigationBarStaticComponentsKeys keys,
    required ModalRoute<dynamic>? route,
    required Widget? userLeading,
    required bool automaticallyImplyLeading,
    required bool automaticallyImplyTitle,
    required String? previousPageTitle,
    required Widget? userMiddle,
    required Widget? userTrailing,
    required Widget? userLargeTitle,
    required Widget? largeTitleActions,
    required Widget? appbarBottom,
    required EdgeInsetsDirectional? padding,
    required bool large,
  })  : leading = createLeading(
          leadingKey: keys.leadingKey,
          userLeading: userLeading,
          route: route,
          automaticallyImplyLeading: automaticallyImplyLeading,
          padding: padding,
        ),
        backChevron = createBackChevron(
          backChevronKey: keys.backChevronKey,
          userLeading: userLeading,
          route: route,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
        backLabel = createBackLabel(
          backLabelKey: keys.backLabelKey,
          userLeading: userLeading,
          route: route,
          previousPageTitle: previousPageTitle,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
        middle = createMiddle(
          middleKey: keys.middleKey,
          userMiddle: userMiddle,
          userLargeTitle: userLargeTitle,
          route: route,
          automaticallyImplyTitle: automaticallyImplyTitle,
          large: large,
        ),
        trailing = createTrailing(
          trailingKey: keys.trailingKey,
          userTrailing: userTrailing,
          padding: padding,
        ),
        largeTitle = createLargeTitle(
          largeTitleKey: keys.largeTitleKey,
          userLargeTitle: userLargeTitle,
          route: route,
          automaticImplyTitle: automaticallyImplyTitle,
          large: large,
        ),
        largeTitleActions = createLargeTitleActions(
          largeTitleActionsKey: keys.largeTitleActionsKey,
          largeTitleActions: largeTitleActions,
          padding: padding,
        ),
        appbarBottom = createAppbarBottom(
          appbarBottomKey: keys.appbarBottomKey,
          appbarBottom: appbarBottom,
        );

  final KeyedSubtree? appbarBottom;
  final KeyedSubtree? backChevron;
  final KeyedSubtree? backLabel;
  final KeyedSubtree? largeTitle;
  final KeyedSubtree? largeTitleActions;
  final KeyedSubtree? leading;
  final KeyedSubtree? middle;
  final KeyedSubtree? trailing;

  static KeyedSubtree? createLeading({
    required GlobalKey leadingKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
    required EdgeInsetsDirectional? padding,
  }) {
    Widget? leadingContent;

    if (userLeading != null) {
      leadingContent = userLeading;
    } else if (automaticallyImplyLeading && route is PageRoute && route.canPop && route.fullscreenDialog) {
      leadingContent = CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          route.navigator!.maybePop();
        },
        child: const Text('Close'),
      );
    } else if (!automaticallyImplyLeading && userLeading == null) {
      leadingContent = const SizedBox();
    }

    if (leadingContent == null) {
      return null;
    }

    return KeyedSubtree(
      key: leadingKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: padding?.start ?? 0,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 32,
          ),
          child: leadingContent,
        ),
      ),
    );
  }

  static KeyedSubtree? createBackChevron({
    required GlobalKey backChevronKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
  }) {
    if (userLeading != null ||
        !automaticallyImplyLeading ||
        route == null ||
        !route.canPop ||
        (route is PageRoute && route.fullscreenDialog)) {
      return null;
    }

    return KeyedSubtree(key: backChevronKey, child: const BackChevron());
  }

  static KeyedSubtree? createBackLabel({
    required GlobalKey backLabelKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
    required String? previousPageTitle,
  }) {
    if (userLeading != null ||
        !automaticallyImplyLeading ||
        route == null ||
        !route.canPop ||
        (route is PageRoute && route.fullscreenDialog)) {
      return null;
    }

    return KeyedSubtree(
      key: backLabelKey,
      child: BackLabel(
        specifiedPreviousTitle: previousPageTitle,
        route: route,
      ),
    );
  }

  static KeyedSubtree? createMiddle({
    required GlobalKey middleKey,
    required Widget? userMiddle,
    required Widget? userLargeTitle,
    required bool large,
    required bool automaticallyImplyTitle,
    required ModalRoute<dynamic>? route,
  }) {
    var middleContent = userMiddle;

    if (large) {
      middleContent ??= userLargeTitle;
    }

    middleContent ??= _derivedTitle(
      automaticallyImplyTitle: automaticallyImplyTitle,
      currentRoute: route,
    );

    if (middleContent == null) {
      return null;
    }

    return KeyedSubtree(
      key: middleKey,
      child: middleContent,
    );
  }

  static KeyedSubtree? createTrailing({
    required GlobalKey trailingKey,
    required Widget? userTrailing,
    required EdgeInsetsDirectional? padding,
  }) {
    if (userTrailing == null) {
      return null;
    }

    return KeyedSubtree(
      key: trailingKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          end: padding?.end ?? 0,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 32,
          ),
          child: userTrailing,
        ),
      ),
    );
  }

  static KeyedSubtree? createLargeTitle({
    required GlobalKey largeTitleKey,
    required Widget? userLargeTitle,
    required bool large,
    required bool automaticImplyTitle,
    required ModalRoute<dynamic>? route,
  }) {
    if (!large) {
      return null;
    }

    final largeTitleContent = userLargeTitle ??
        _derivedTitle(
          automaticallyImplyTitle: automaticImplyTitle,
          currentRoute: route,
        );

    assert(
      largeTitleContent != null,
      'largeTitle was not provided and there was no title from the route.',
    );

    return KeyedSubtree(
      key: largeTitleKey,
      child: largeTitleContent!,
    );
  }

  static KeyedSubtree? createLargeTitleActions({
    required GlobalKey largeTitleActionsKey,
    required Widget? largeTitleActions,
    required EdgeInsetsDirectional? padding,
  }) {
    if (largeTitleActions == null) {
      return null;
    }

    return KeyedSubtree(
      key: largeTitleActionsKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          end: padding?.end ?? 0,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 32,
          ),
          child: largeTitleActions,
        ),
      ),
    );
  }

  static KeyedSubtree? createAppbarBottom({
    required GlobalKey appbarBottomKey,
    required Widget? appbarBottom,
  }) {
    return KeyedSubtree(
      key: appbarBottomKey,
      child: appbarBottom!,
    );
  }

  static Widget? _derivedTitle({
    required bool automaticallyImplyTitle,
    ModalRoute<dynamic>? currentRoute,
  }) {
    if (automaticallyImplyTitle && currentRoute is CupertinoRouteTransitionMixin && currentRoute.title != null) {
      return Text(currentRoute.title!);
    }

    return null;
  }
}

Widget wrapWithBackground({
  required Color backgroundColor,
  required Widget child,
  Border? border,
  Brightness? brightness,
  bool updateSystemUiOverlay = true,
  bool hasBackgroundBlur = false,
}) {
  var result = child;
  if (updateSystemUiOverlay) {
    final isDark = backgroundColor.computeLuminance() < 0.179;
    final newBrightness = brightness ?? (isDark ? Brightness.dark : Brightness.light);
    final SystemUiOverlayStyle overlayStyle;
    switch (newBrightness) {
      case Brightness.dark:
        overlayStyle = SystemUiOverlayStyle.light;
      case Brightness.light:
        overlayStyle = SystemUiOverlayStyle.dark;
    }

    result = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: overlayStyle.statusBarColor,
        statusBarBrightness: overlayStyle.statusBarBrightness,
        statusBarIconBrightness: overlayStyle.statusBarIconBrightness,
        systemStatusBarContrastEnforced: overlayStyle.systemStatusBarContrastEnforced,
      ),
      child: result,
    );
  }
  final childWithBackground = DecoratedBox(
    decoration: BoxDecoration(
      border: border,
      color: backgroundColor,
    ),
    child: result,
  );

  if (backgroundColor.alpha == 0xFF) {
    return childWithBackground;
  }

  return hasBackgroundBlur
      ? ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: childWithBackground,
          ),
        )
      : childWithBackground;
}

bool isTransitionable(BuildContext context) {
  final ModalRoute<dynamic>? route = ModalRoute.of(context);

  return route is PageRoute && !route.fullscreenDialog;
}

RectTween linearTranslateWithLargestRectSizeTween(Rect? begin, Rect? end) {
  final largestSize = Size(
    math.max(begin!.size.width, end!.size.width),
    math.max(begin.size.height, end.size.height),
  );

  return RectTween(
    begin: begin.topLeft & largestSize,
    end: end.topLeft & largestSize,
  );
}

Widget navBarHeroLaunchPadBuilder(Widget child) {
  assert(child is TransitionableNavigationBar);

  return Visibility(
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    visible: false,
    child: child,
  );
}

Widget navBarHeroFlightShuttleBuilder(
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  assert(fromHeroContext.widget is Hero);
  assert(toHeroContext.widget is Hero);

  final fromHeroWidget = fromHeroContext.widget as Hero;
  final toHeroWidget = toHeroContext.widget as Hero;

  assert(fromHeroWidget.child is TransitionableNavigationBar);
  assert(toHeroWidget.child is TransitionableNavigationBar);

  final fromNavBar = fromHeroWidget.child as TransitionableNavigationBar;
  final toNavBar = toHeroWidget.child as TransitionableNavigationBar;

  assert(
    fromNavBar.componentsKeys.navBarBoxKey.currentContext!.owner != null,
    'The from nav bar to Hero must have been mounted in the previous frame',
  );
  assert(
    toNavBar.componentsKeys.navBarBoxKey.currentContext!.owner != null,
    'The to nav bar to Hero must have been mounted in the previous frame',
  );

  switch (flightDirection) {
    case HeroFlightDirection.push:
      return NavigationBarTransition(
        animation: animation,
        bottomNavBar: fromNavBar,
        topNavBar: toNavBar,
      );
    case HeroFlightDirection.pop:
      return NavigationBarTransition(
        animation: animation,
        bottomNavBar: toNavBar,
        topNavBar: fromNavBar,
      );
  }
}

class NavigationBarStaticComponentsKeys {
  NavigationBarStaticComponentsKeys()
      : navBarBoxKey = GlobalKey(debugLabel: 'Navigation bar render box'),
        leadingKey = GlobalKey(debugLabel: 'Leading'),
        backChevronKey = GlobalKey(debugLabel: 'Back chevron'),
        backLabelKey = GlobalKey(debugLabel: 'Back label'),
        middleKey = GlobalKey(debugLabel: 'Middle'),
        trailingKey = GlobalKey(debugLabel: 'Trailing'),
        largeTitleKey = GlobalKey(debugLabel: 'Large title'),
        searchBarKey = GlobalKey(debugLabel: 'Search Bar'),
        largeTitleActionsKey = GlobalKey(debugLabel: 'largeTitleActionsKey'),
        appbarBottomKey = GlobalKey(debugLabel: 'appbarBottomKey');

  final GlobalKey appbarBottomKey;
  final GlobalKey backChevronKey;
  final GlobalKey backLabelKey;
  final GlobalKey largeTitleActionsKey;
  final GlobalKey largeTitleKey;
  final GlobalKey leadingKey;
  final GlobalKey middleKey;
  final GlobalKey navBarBoxKey;
  final GlobalKey searchBarKey;
  final GlobalKey trailingKey;
}

@immutable
class HeroTag {
  const HeroTag(this.navigator);

  final NavigatorState? navigator;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is HeroTag && other.navigator == navigator;
  }

  @override
  int get hashCode => identityHashCode(navigator);

  @override
  String toString() => 'Default Hero tag for Cupertino navigation bars with navigator $navigator';
}

class BackChevron extends StatelessWidget {
  const BackChevron({super.key});

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final textStyle = DefaultTextStyle.of(context).style;

    Widget iconWidget = Padding(
      padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
      child: Text.rich(
        TextSpan(
          text: String.fromCharCode(CupertinoIcons.back.codePoint),
          style: TextStyle(
            inherit: false,
            color: textStyle.color,
            fontSize: 25,
            fontFamily: CupertinoIcons.back.fontFamily,
            package: CupertinoIcons.back.fontPackage,
          ),
        ),
      ),
    );
    switch (textDirection) {
      case TextDirection.rtl:
        iconWidget = Transform(
          transform: Matrix4.identity()..scale(-1.0, 1, 1),
          alignment: Alignment.center,
          transformHitTests: false,
          child: iconWidget,
        );
      case TextDirection.ltr:
        break;
    }

    return iconWidget;
  }
}

class SuperCupertinoNavigationBarBackButton extends StatelessWidget {
  const SuperCupertinoNavigationBarBackButton({
    required this.actionTextStyle,
    super.key,
    this.color,
    this.previousPageTitle,
    this.onPressed,
  })  : backChevron = null,
        backLabel = null;

  const SuperCupertinoNavigationBarBackButton.assemble(
    this.backChevron,
    this.actionTextStyle,
    this.backLabel, {
    super.key,
  })  : previousPageTitle = null,
        color = null,
        onPressed = null;

  final TextStyle actionTextStyle;
  final Widget? backChevron;
  final Widget? backLabel;
  final Color? color;
  final VoidCallback? onPressed;
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
    if (onPressed == null) {
      assert(
        currentRoute?.canPop ?? false,
        'CupertinoNavigationBarBackButton should only be used in routes that can be popped',
      );
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Semantics(
        container: true,
        excludeSemantics: true,
        label: 'Back',
        button: true,
        child: DefaultTextStyle(
          style: actionTextStyle,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 50),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(padding: EdgeInsetsDirectional.only(start: 8)),
                backChevron ?? const BackChevron(),
                const Padding(padding: EdgeInsetsDirectional.only(start: 6)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: backLabel ??
                        BackLabel(
                          specifiedPreviousTitle: previousPageTitle,
                          route: currentRoute,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

class BackLabel extends StatelessWidget {
  const BackLabel({
    required this.specifiedPreviousTitle,
    required this.route,
    super.key,
  });

  final ModalRoute<dynamic>? route;
  final String? specifiedPreviousTitle;

  Widget _buildPreviousTitleWidget(String? previousTitle) {
    if (previousTitle == null) {
      return const SizedBox.shrink();
    }

    var textWidget = Text(
      previousTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    if (previousTitle.length > 12) {
      textWidget = const Text('Back');
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1,
      child: textWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (specifiedPreviousTitle != null) {
      return _buildPreviousTitleWidget(specifiedPreviousTitle);
    } else if (route is CupertinoRouteTransitionMixin<dynamic> && !route!.isFirst) {
      final cupertinoRoute = route! as CupertinoRouteTransitionMixin<dynamic>;

      return ValueListenableBuilder<String?>(
        valueListenable: cupertinoRoute.previousTitle,
        builder: (_, value, __) => _buildPreviousTitleWidget(value),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class TransitionableNavigationBar extends StatelessWidget {
  TransitionableNavigationBar({
    required this.componentsKeys,
    required this.backgroundColor,
    required this.backButtonTextStyle,
    required this.titleTextStyle,
    required this.largeTitleTextStyle,
    required this.border,
    required this.hasUserMiddle,
    required this.largeExpanded,
    required this.searchBarHasFocus,
    required this.child,
  })  : assert(!largeExpanded || largeTitleTextStyle != null),
        super(key: componentsKeys.navBarBoxKey);

  final TextStyle backButtonTextStyle;
  final Color? backgroundColor;
  final Border? border;
  final Widget child;
  final NavigationBarStaticComponentsKeys componentsKeys;
  final bool hasUserMiddle;
  final bool largeExpanded;
  final TextStyle? largeTitleTextStyle;
  final bool searchBarHasFocus;
  final TextStyle titleTextStyle;

  RenderBox get renderBox {
    final box = componentsKeys.navBarBoxKey.currentContext!.findRenderObject()! as RenderBox;
    assert(
      box.attached,
      '_TransitionableNavigationBar.renderBox should be called when building '
      'hero flight shuttles when the from and the to nav bar boxes are already '
      'laid out and painted.',
    );

    return box;
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      var isInHero = false;
      context.visitAncestorElements((ancestor) {
        if (ancestor is ComponentElement) {
          assert(
            ancestor.widget.runtimeType != NavigationBarTransition,
            'TransitionableNavigationBar should never re-appear inside '
            'NavigationBarTransition. Keyed TransitionableNavigationBar should '
            'only serve as anchor points in routes rather than appearing inside '
            'Hero flights themselves.',
          );
          if (ancestor.widget.runtimeType == Hero) {
            isInHero = true;
          }
        }

        return true;
      });
      assert(
        isInHero,
        '_TransitionableNavigationBar should only be added as the immediate '
        'child of Hero widgets.',
      );

      return true;
    }());

    return child;
  }
}

class NavigationBarTransition extends StatelessWidget {
  NavigationBarTransition({
    required this.animation,
    required this.topNavBar,
    required this.bottomNavBar,
    super.key,
  })  : heightTween = Tween<double>(
          begin: bottomNavBar.renderBox.size.height,
          end: topNavBar.renderBox.size.height,
        ),
        backgroundTween = ColorTween(
          begin: bottomNavBar.backgroundColor,
          end: topNavBar.backgroundColor,
        ),
        borderTween = BorderTween(
          begin: bottomNavBar.border,
          end: topNavBar.border,
        );

  final Animation<double> animation;
  final ColorTween backgroundTween;
  final BorderTween borderTween;
  final TransitionableNavigationBar bottomNavBar;
  final Tween<double> heightTween;
  final TransitionableNavigationBar topNavBar;

  @override
  Widget build(BuildContext context) {
    final componentsTransition = _NavigationBarComponentsTransition(
      animation: animation,
      bottomNavBar: bottomNavBar,
      topNavBar: topNavBar,
      directionality: Directionality.of(context),
    );

    final children = <Widget>[
      AnimatedBuilder(
        animation: animation,
        builder: (_, __) {
          return wrapWithBackground(
            updateSystemUiOverlay: false,
            backgroundColor: backgroundTween.evaluate(animation)!,
            border: borderTween.evaluate(animation),
            child: SizedBox(
              height: heightTween.evaluate(animation),
              width: double.infinity,
            ),
          );
        },
      ),
      if (componentsTransition.bottomBackChevron != null) componentsTransition.bottomBackChevron!,
      if (componentsTransition.bottomBackLabel != null) componentsTransition.bottomBackLabel!,
      if (componentsTransition.bottomLeading != null) componentsTransition.bottomLeading!,
      if (componentsTransition.bottomMiddle != null) componentsTransition.bottomMiddle!,
      if (componentsTransition.bottomLargeTitle != null) componentsTransition.bottomLargeTitle!,
      if (componentsTransition.bottomTrailing != null) componentsTransition.bottomTrailing!,
      if (componentsTransition.bottomSearchBar != null) componentsTransition.bottomSearchBar!,
      if (componentsTransition.bottomLargeTitleActions != null) componentsTransition.bottomLargeTitleActions!,
      if (componentsTransition.bottomAppbarBottom != null) componentsTransition.bottomAppbarBottom!,
      if (componentsTransition.topLeading != null) componentsTransition.topLeading!,
      if (componentsTransition.topBackChevron != null) componentsTransition.topBackChevron!,
      if (componentsTransition.topBackLabel != null) componentsTransition.topBackLabel!,
      if (componentsTransition.topMiddle != null) componentsTransition.topMiddle!,
      if (componentsTransition.topTrailing != null) componentsTransition.topTrailing!,
      if (componentsTransition.topSearchBar != null) componentsTransition.topSearchBar!,
      if (componentsTransition.topLargeTitleActions != null) componentsTransition.topLargeTitleActions!,
      if (componentsTransition.topAppbarBottom != null) componentsTransition.topAppbarBottom!,
      if (componentsTransition.topLargeTitle != null) componentsTransition.topLargeTitle!,
    ];

    return MediaQuery.withNoTextScaling(
      child: SizedBox(
        height: math.max(heightTween.begin!, heightTween.end!) + MediaQuery.paddingOf(context).top,
        width: double.infinity,
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}

@immutable
class _NavigationBarComponentsTransition {
  _NavigationBarComponentsTransition({
    required this.animation,
    required TransitionableNavigationBar bottomNavBar,
    required TransitionableNavigationBar topNavBar,
    required TextDirection directionality,
  })  : bottomComponents = bottomNavBar.componentsKeys,
        topComponents = topNavBar.componentsKeys,
        bottomNavBarBox = bottomNavBar.renderBox,
        topNavBarBox = topNavBar.renderBox,
        bottomBackButtonTextStyle = bottomNavBar.backButtonTextStyle,
        topBackButtonTextStyle = topNavBar.backButtonTextStyle,
        bottomTitleTextStyle = bottomNavBar.titleTextStyle,
        topTitleTextStyle = topNavBar.titleTextStyle,
        bottomLargeTitleTextStyle = bottomNavBar.largeTitleTextStyle,
        topLargeTitleTextStyle = topNavBar.largeTitleTextStyle,
        bottomHasUserMiddle = bottomNavBar.hasUserMiddle,
        topHasUserMiddle = topNavBar.hasUserMiddle,
        bottomLargeExpanded = bottomNavBar.largeExpanded,
        topLargeExpanded = topNavBar.largeExpanded,
        bottomSearchBarHasFocus = bottomNavBar.searchBarHasFocus,
        topSearchBarHasFocus = topNavBar.searchBarHasFocus,
        transitionBox = bottomNavBar.renderBox.paintBounds.expandToInclude(topNavBar.renderBox.paintBounds),
        forwardDirection = directionality == TextDirection.ltr ? 1.0 : -1.0;

  static final Animatable<double> fadeIn = Tween<double>(
    begin: 0,
    end: 1,
  );

  static final Animatable<double> fadeOut = Tween<double>(
    begin: 1,
    end: 0,
  );

  final Animation<double> animation;
  final TextStyle bottomBackButtonTextStyle;
  final NavigationBarStaticComponentsKeys bottomComponents;
  final bool bottomHasUserMiddle;
  final bool bottomLargeExpanded;
  final TextStyle? bottomLargeTitleTextStyle;
  final RenderBox bottomNavBarBox;
  final bool bottomSearchBarHasFocus;
  final TextStyle bottomTitleTextStyle;
  final double forwardDirection;
  final TextStyle topBackButtonTextStyle;
  final NavigationBarStaticComponentsKeys topComponents;
  final bool topHasUserMiddle;
  final bool topLargeExpanded;
  final TextStyle? topLargeTitleTextStyle;
  final RenderBox topNavBarBox;
  final bool topSearchBarHasFocus;
  final TextStyle topTitleTextStyle;
  final Rect transitionBox;

  RelativeRect positionInTransitionBox(
    GlobalKey key, {
    required RenderBox from,
  }) {
    final componentBox = key.currentContext!.findRenderObject()! as RenderBox;
    assert(componentBox.attached);

    return RelativeRect.fromRect(
      componentBox.localToGlobal(Offset.zero, ancestor: from) & componentBox.size,
      transitionBox,
    );
  }

  FixedSizeSlidingTransition slideFromLeadingEdge({
    required GlobalKey fromKey,
    required RenderBox fromNavBarBox,
    required GlobalKey toKey,
    required RenderBox toNavBarBox,
    required Widget child,
  }) {
    final fromBox = fromKey.currentContext!.findRenderObject()! as RenderBox;
    final toBox = toKey.currentContext!.findRenderObject()! as RenderBox;

    final isLTR = forwardDirection > 0;

    final fromAnchorLocal = Offset(
      isLTR ? 0 : fromBox.size.width,
      fromBox.size.height / 2,
    );
    final toAnchorLocal = Offset(
      isLTR ? 0 : toBox.size.width,
      toBox.size.height / 2,
    );
    final fromAnchorInFromBox = fromBox.localToGlobal(fromAnchorLocal, ancestor: fromNavBarBox);
    final toAnchorInToBox = toBox.localToGlobal(toAnchorLocal, ancestor: toNavBarBox);

    final translation = isLTR
        ? toAnchorInToBox - fromAnchorInFromBox
        : Offset(
              toNavBarBox.size.width - toAnchorInToBox.dx,
              toAnchorInToBox.dy,
            ) -
            Offset(
              fromNavBarBox.size.width - fromAnchorInFromBox.dx,
              fromAnchorInFromBox.dy,
            );

    final fromBoxMargin = positionInTransitionBox(fromKey, from: fromNavBarBox);
    final fromOriginInTransitionBox = Offset(
      isLTR ? fromBoxMargin.left : fromBoxMargin.right,
      fromBoxMargin.top,
    );

    final anchorMovementInTransitionBox = Tween<Offset>(
      begin: fromOriginInTransitionBox,
      end: fromOriginInTransitionBox + translation,
    );

    return FixedSizeSlidingTransition(
      isLTR: isLTR,
      offsetAnimation: animation.drive(anchorMovementInTransitionBox),
      size: fromBox.size,
      child: child,
    );
  }

  Animation<double> fadeInFrom(double t, {Curve curve = Curves.easeIn}) {
    return animation.drive(
      fadeIn.chain(
        CurveTween(curve: Interval(t, 1, curve: curve)),
      ),
    );
  }

  Animation<double> fadeOutBy(double t, {Curve curve = Curves.easeOut}) {
    return animation.drive(
      fadeOut.chain(
        CurveTween(curve: Interval(0, t, curve: curve)),
      ),
    );
  }

  Widget? get bottomLeading {
    final bottomLeading = bottomComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomLeading == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.leadingKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.4),
        child: Material(color: Colors.transparent, child: bottomLeading.child),
      ),
    );
  }

  Widget? get topLeading {
    final topLeading = topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (topLeading == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(topComponents.leadingKey, from: topNavBarBox),
      child: FadeTransition(
        opacity: fadeInFrom(0.6),
        child: Material(
          color: Colors.transparent,
          child: topLeading.child,
        ),
      ),
    );
  }

  Widget? get bottomBackChevron {
    final bottomBackChevron = bottomComponents.backChevronKey.currentWidget as KeyedSubtree?;

    if (bottomBackChevron == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.backChevronKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.6),
        child: DefaultTextStyle(
          style: bottomBackButtonTextStyle,
          child: bottomBackChevron.child,
        ),
      ),
    );
  }

  Widget? get topBackChevron {
    final topBackChevron = topComponents.backChevronKey.currentWidget as KeyedSubtree?;
    final bottomBackChevron = bottomComponents.backChevronKey.currentWidget as KeyedSubtree?;

    if (topBackChevron == null) {
      return null;
    }

    final to = positionInTransitionBox(
      topComponents.backChevronKey,
      from: topNavBarBox,
    );
    var from = to;

    if (bottomBackChevron == null) {
      final topBackChevronBox = topComponents.backChevronKey.currentContext!.findRenderObject()! as RenderBox;
      from = to.shift(
        Offset(
          forwardDirection * topBackChevronBox.size.width * 2.0,
          0,
        ),
      );
    }

    final positionTween = RelativeRectTween(
      begin: from,
      end: to,
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeInFrom(bottomBackChevron == null ? 0.7 : 0.4),
        child: DefaultTextStyle(
          style: topBackButtonTextStyle,
          child: topBackChevron.child,
        ),
      ),
    );
  }

  Widget? get bottomBackLabel {
    final bottomBackLabel = bottomComponents.backLabelKey.currentWidget as KeyedSubtree?;

    if (bottomBackLabel == null) {
      return null;
    }

    final from = positionInTransitionBox(
      bottomComponents.backLabelKey,
      from: bottomNavBarBox,
    );

    final positionTween = RelativeRectTween(
      begin: from,
      end: from.shift(
        Offset(
          forwardDirection * (-bottomNavBarBox.size.width / 2.0),
          0,
        ),
      ),
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeOutBy(0.2),
        child: DefaultTextStyle(
          style: bottomBackButtonTextStyle,
          child: bottomBackLabel.child,
        ),
      ),
    );
  }

  Widget? get topBackLabel {
    final bottomMiddle = bottomComponents.middleKey.currentWidget as KeyedSubtree?;
    final bottomLargeTitle = bottomComponents.largeTitleKey.currentWidget as KeyedSubtree?;
    final topBackLabel = topComponents.backLabelKey.currentWidget as KeyedSubtree?;

    if (topBackLabel == null) {
      return null;
    }

    final topBackLabelOpacity =
        topComponents.backLabelKey.currentContext?.findAncestorRenderObjectOfType<RenderAnimatedOpacity>();

    Animation<double>? midClickOpacity;
    if (topBackLabelOpacity != null && topBackLabelOpacity.opacity.value < 1.0) {
      midClickOpacity = animation.drive(
        Tween<double>(
          begin: 0,
          end: topBackLabelOpacity.opacity.value,
        ),
      );
    }

    if (bottomLargeTitle != null && bottomLargeExpanded) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.largeTitleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: midClickOpacity ?? fadeInFrom(0.4),
          child: DefaultTextStyleTransition(
            style: animation.drive(
              TextStyleTween(
                begin: bottomLargeTitleTextStyle,
                end: topBackButtonTextStyle,
              ),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: topBackLabel.child,
          ),
        ),
      );
    }

    if (bottomMiddle != null) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.middleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: midClickOpacity ?? fadeInFrom(0.3),
          child: DefaultTextStyleTransition(
            style: animation.drive(
              TextStyleTween(
                begin: bottomTitleTextStyle,
                end: topBackButtonTextStyle,
              ),
            ),
            child: topBackLabel.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get bottomMiddle {
    final bottomMiddle = bottomComponents.middleKey.currentWidget as KeyedSubtree?;
    final topBackLabel = topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final topLeading = topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomSearchBarHasFocus) {
      return null;
    }

    if (!bottomHasUserMiddle && bottomLargeExpanded) {
      return null;
    }

    if (bottomMiddle != null && topBackLabel != null) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.middleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: fadeOutBy(bottomHasUserMiddle ? 0.4 : 0.7),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyleTransition(
              style: animation.drive(
                TextStyleTween(
                  begin: bottomTitleTextStyle,
                  end: topBackButtonTextStyle,
                ),
              ),
              child: bottomMiddle.child,
            ),
          ),
        ),
      );
    }

    if (bottomMiddle != null && topLeading != null) {
      return Positioned.fromRelativeRect(
        rect: positionInTransitionBox(
          bottomComponents.middleKey,
          from: bottomNavBarBox,
        ),
        child: FadeTransition(
          opacity: fadeOutBy(bottomHasUserMiddle ? 0.4 : 0.7),
          child: DefaultTextStyle(
            style: bottomTitleTextStyle,
            child: bottomMiddle.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get topMiddle {
    final topMiddle = topComponents.middleKey.currentWidget as KeyedSubtree?;

    if (topMiddle == null) {
      return null;
    }

    if (!topHasUserMiddle && topLargeExpanded) {
      return null;
    }

    final to = positionInTransitionBox(topComponents.middleKey, from: topNavBarBox);
    final toBox = topComponents.middleKey.currentContext!.findRenderObject()! as RenderBox;

    final isLTR = forwardDirection > 0;

    final toAnchorInTransitionBox = Offset(
      isLTR ? to.left : to.right,
      to.top,
    );

    final anchorMovementInTransitionBox = Tween<Offset>(
      begin: Offset(
        topNavBarBox.size.width - toBox.size.width / 2,
        to.top,
      ),
      end: toAnchorInTransitionBox,
    );

    return FixedSizeSlidingTransition(
      isLTR: isLTR,
      offsetAnimation: animation.drive(anchorMovementInTransitionBox),
      size: toBox.size,
      child: FadeTransition(
        opacity: fadeInFrom(0.25),
        child: DefaultTextStyle(
          style: topTitleTextStyle,
          child: topMiddle.child,
        ),
      ),
    );
  }

  Widget? get bottomLargeTitle {
    final bottomLargeTitle = bottomComponents.largeTitleKey.currentWidget as KeyedSubtree?;
    final topBackLabel = topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final topLeading = topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomLargeTitle == null || !bottomLargeExpanded) {
      return null;
    }

    if (topBackLabel != null) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.largeTitleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: fadeOutBy(0.6),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyleTransition(
              style: animation.drive(
                TextStyleTween(
                  begin: bottomLargeTitleTextStyle,
                  end: topBackButtonTextStyle,
                ),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: bottomLargeTitle.child,
            ),
          ),
        ),
      );
    }

    if (topLeading != null) {
      final from = positionInTransitionBox(
        bottomComponents.largeTitleKey,
        from: bottomNavBarBox,
      );

      final positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(
            forwardDirection * bottomNavBarBox.size.width / 4.0,
            0,
          ),
        ),
      );

      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.4),
          child: DefaultTextStyle(
            style: bottomLargeTitleTextStyle!,
            child: bottomLargeTitle.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get topLargeTitle {
    final topLargeTitle = topComponents.largeTitleKey.currentWidget as KeyedSubtree?;

    if (topLargeTitle == null || !topLargeExpanded) {
      return null;
    }

    final to = positionInTransitionBox(
      topComponents.largeTitleKey,
      from: topNavBarBox,
    );

    final dynamic positionTween = RelativeRectTween(
      begin: to.shift(
        Offset(
          forwardDirection * topNavBarBox.size.width,
          0,
        ),
      ),
      end: to,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: custom,
        reverseCurve: custom,
      ),
    );

    return PositionedTransition(
      rect: positionTween,
      child: DefaultTextStyle(
        style: topLargeTitleTextStyle!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        child: topLargeTitle.child,
      ),
    );
  }

  Widget? get bottomTrailing {
    final bottomTrailing = bottomComponents.trailingKey.currentWidget as KeyedSubtree?;

    if (bottomTrailing == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.trailingKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.6),
        child: bottomTrailing.child,
      ),
    );
  }

  Widget? get topTrailing {
    final topTrailing = topComponents.trailingKey.currentWidget as KeyedSubtree?;

    if (topTrailing == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        topComponents.trailingKey,
        from: topNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeInFrom(0.4),
        child: topTrailing.child,
      ),
    );
  }

  Widget? get bottomSearchBar {
    final bottomSearchBar = bottomComponents.searchBarKey.currentWidget as KeyedSubtree?;
    final topBackLabel = topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final topLeading = topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomSearchBar == null || !bottomLargeExpanded) {
      return null;
    }

    if (topLeading != null || topBackLabel != null) {
      final from = positionInTransitionBox(
        bottomComponents.searchBarKey,
        from: bottomNavBarBox,
      );

      final positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(
            -4.65 * forwardDirection * bottomNavBarBox.size.width,
            0,
          ),
        ),
      );

      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.1),
          child: bottomSearchBar.child,
        ),
      );
    }

    return null;
  }

  Widget? get topSearchBar {
    final topSearchBar = topComponents.searchBarKey.currentWidget as KeyedSubtree?;

    if (topSearchBar == null) {
      return null;
    }

    final to = positionInTransitionBox(topComponents.searchBarKey, from: topNavBarBox);

    final dynamic positionTween = RelativeRectTween(
      begin: to.shift(
        Offset(
          forwardDirection * topNavBarBox.size.width,
          0,
        ),
      ),
      end: to,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: custom,
        reverseCurve: custom,
      ),
    );

    return PositionedTransition(
      rect: positionTween,
      child: topSearchBar.child,
    );
  }

  Widget? get bottomLargeTitleActions {
    final bottomLargeTitleActions = bottomComponents.largeTitleActionsKey.currentWidget as KeyedSubtree?;

    if (bottomLargeTitleActions == null) {
      return null;
    }

    if (!bottomLargeExpanded) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        bottomComponents.largeTitleActionsKey,
        from: bottomNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeOutBy(0.4),
        child: bottomLargeTitleActions.child,
      ),
    );
  }

  Widget? get topLargeTitleActions {
    final topLargeTitleActions = topComponents.largeTitleActionsKey.currentWidget as KeyedSubtree?;

    if (topLargeTitleActions == null) {
      return null;
    }

    if (!topLargeExpanded) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(
        topComponents.largeTitleActionsKey,
        from: topNavBarBox,
      ),
      child: FadeTransition(
        opacity: fadeInFrom(0.6),
        child: topLargeTitleActions.child,
      ),
    );
  }

  Widget? get bottomAppbarBottom {
    final bottomAppbarBottom = bottomComponents.appbarBottomKey.currentWidget as KeyedSubtree?;

    if (bottomAppbarBottom == null) {
      return null;
    }

    if (topLeading != null || topBackLabel != null) {
      final from = positionInTransitionBox(
        bottomComponents.appbarBottomKey,
        from: bottomNavBarBox,
      );

      final positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(
            -4.65 * forwardDirection * bottomNavBarBox.size.width,
            0,
          ),
        ),
      );

      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.7),
          child: Material(
            color: Colors.transparent,
            child: bottomAppbarBottom.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get topAppbarBottom {
    final topAppbarBottom = topComponents.appbarBottomKey.currentWidget as KeyedSubtree?;

    if (topAppbarBottom == null) {
      return null;
    }

    final to = positionInTransitionBox(
      topComponents.appbarBottomKey,
      from: topNavBarBox,
    );

    final dynamic positionTween = RelativeRectTween(
      begin: to.shift(
        Offset(
          forwardDirection * topNavBarBox.size.width,
          0,
        ),
      ),
      end: to,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: custom,
        reverseCurve: custom,
      ),
    );

    return PositionedTransition(
      rect: positionTween,
      child: Material(color: Colors.transparent, child: topAppbarBottom.child),
    );
  }
}

Curve get custom => const Cubic(.83, .19, .67, .56);

class FixedSizeSlidingTransition extends AnimatedWidget {
  const FixedSizeSlidingTransition({
    required this.isLTR,
    required this.offsetAnimation,
    required this.size,
    required this.child,
    super.key,
  }) : super(listenable: offsetAnimation);

  final Widget child;
  final bool isLTR;
  final Animation<Offset> offsetAnimation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offsetAnimation.value.dy,
      left: isLTR ? offsetAnimation.value.dx : null,
      right: isLTR ? null : offsetAnimation.value.dx,
      width: size.width,
      height: size.height,
      child: child,
    );
  }
}
