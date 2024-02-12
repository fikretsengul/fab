// ignore_for_file: avoid_returning_widgets

import 'package:flutter/material.dart';

import 'route.dart';

class PopScopeAwareCupertinoPageTransitionBuilder extends PageTransitionsBuilder {
  const PopScopeAwareCupertinoPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return PopScopeAwareCupertinoRouteTransitionMixin.buildPageTransitions<T>(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
