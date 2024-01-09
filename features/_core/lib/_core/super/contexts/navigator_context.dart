// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

const String noContextError = 'No context found.';

@immutable
final class NavigatorContext {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<AutoRouterState> autoRouterKey = GlobalKey<AutoRouterState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool get hasContext => context != null;

  BuildContext? get context {
    final context = navigatorKey.currentContext;
    assert(context != null, noContextError);

    return context;
  }

  StackRouter? get _controller {
    return autoRouterKey.currentState?.controller;
  }

  void reevaluateGuards() => _controller?.reevaluateGuards();

  Future<T?> push<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) async =>
      _controller?.push<T>(route, onFailure: onFailure);

  Future<void> navigate(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) async =>
      _controller?.navigate(route, onFailure: onFailure);

  Future<void> navigateNamed(
    String path, {
    bool includePrefixMatches = false,
    OnNavigationFailure? onFailure,
  }) async =>
      _controller?.navigateNamed(
        path,
        includePrefixMatches: includePrefixMatches,
        onFailure: onFailure,
      );

  Future<T?> replace<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) async =>
      _controller?.replace<T>(route, onFailure: onFailure);

  Future<void> replaceAll(
    List<PageRouteInfo> routes, {
    OnNavigationFailure? onFailure,
    bool updateExistingRoutes = true,
  }) async =>
      _controller?.replaceAll(routes, onFailure: onFailure, updateExistingRoutes: updateExistingRoutes);

  Future<bool?> pop<T extends Object?>([T? result]) async => _controller?.pop<T>(result);

  Future<void> popForced<T extends Object?>([T? result]) async => _controller?.popForced(result);

  void back() => _controller?.back();

  T? innerRouterOf<T extends RoutingController>(String routeKey) => _controller?.innerRouterOf<T>(routeKey);
}
