// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/locator/locator.dart';
import 'package:deps/packages/go_router.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../page/page_delegate.dart';
import '../page/page_extensions.dart';
import 'i_router.dart';
import 'route_info.dart';

/// A handler function type for redirection logic.
/// It determines if a redirection is needed based on the current route info and authentication state.
typedef RedirectHandler = String? Function(
  BuildContext context, {
  required bool isAuthenticated,
  required RouteInfo info,
});

/// `Router` class implements `IRouter`, managing navigation and routing configurations.
/// It utilizes `GoRouter` for efficient and flexible routing within Flutter apps.
class Router implements IRouter {
  /// Factory constructor for creating a `Router` instance.
  /// Configures the router with necessary handlers, error pages, and routes.
  factory Router({
    required RedirectHandler onRedirect,
    required ErrorPage errorPage,
    required List<PageDelegate> pages,
    required ValueListenable<bool> refreshListenable,
    String homePath = '/',
  }) {
    final rootKey = GlobalKey<NavigatorState>();
    final routerConfig = GoRouter(
      navigatorKey: rootKey,
      initialLocation: homePath,
      refreshListenable: refreshListenable,
      errorPageBuilder: errorPage.toPage,
      routes: _createRoutes(rootKey, pages),
      redirect: (context, state) => onRedirect(
        context,
        isAuthenticated: refreshListenable.value,
        info: RouteInfo(
          path: state.uri.toString(),
          pathParams: state.pathParameters,
          queryParams: state.uri.queryParameters,
        ),
      ),
      observers: [TalkerRouteObserver(di<Talker>())],
    );

    return Router._(routerConfig);
  }

  /// Private constructor for internal use.
  Router._(this.config);

  @override
  final RouterConfig<Object> config;

  /// Navigates to a named route with optional path and query parameters.
  @override
  void route(
    BuildContext context,
    String name, {
    Map<String, String> pathParams = const {},
    Map<String, dynamic> queryParams = const {},
  }) {
    context.goNamed(
      name,
      pathParameters: pathParams,
      queryParameters: queryParams,
    );
  }

  /// Generates a list of routes from the provided page delegates.
  /// Converts each `PageDelegate` into a `RouteBase` object for the router.
  static List<RouteBase> _createRoutes(
    GlobalKey<NavigatorState> rootKey,
    List<PageDelegate> delegates,
  ) {
    return delegates.map((page) => page.toRoute(rootKey, null)).toList(growable: false);
  }
}
