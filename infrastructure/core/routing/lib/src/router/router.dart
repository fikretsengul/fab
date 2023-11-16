import 'package:deps/packages/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../others/extensions/router_extensions.dart';
import '../page/page_delegate.dart';
import 'i_router.dart';
import 'route_info.dart';

typedef RedirectHandler = String? Function(
  BuildContext context, {
  required bool isAuthenticated,
  required RouteInfo info,
});

/// The primary router class responsible for
/// navigation and routing configurations.
class Router implements IRouter {
  /// Factory constructor for the Router.
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
/*       observers: [TalkerRouteObserver(di<Talker>())], */
    );

    return Router._(routerConfig);
  }

  Router._(this.config);

  @override
  final RouterConfig<Object> config;

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

  /// Creates a list of routes from the provided page delegates.
  static List<RouteBase> _createRoutes(
    GlobalKey<NavigatorState> rootKey,
    List<PageDelegate> delegates,
  ) {
    return delegates
        .map(
          (page) => page.toRoute(rootKey, null),
        )
        .toList(growable: false);
  }
}
