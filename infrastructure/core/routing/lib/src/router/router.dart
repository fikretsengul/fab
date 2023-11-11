import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../application/application_scope.dart';
import '../page/page_delegate.dart';
import '../page/page_scope.dart';
import '../page/page_type.dart';
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
      errorPageBuilder: errorPage._toPage,
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
          (page) => page._toRoute(rootKey, null),
        )
        .toList(growable: false);
  }
}

/// Extensions to provide route conversion methods for
/// PageDelegate, SinglePage, LayoutPage, and ErrorPage.
extension _PageDelegateExtensions on PageDelegate {
  RouteBase _toRoute(
    GlobalKey<NavigatorState> rootKey,
    GlobalKey<NavigatorState>? shellKey,
  ) {
    if (this is SinglePage) {
      return (this as SinglePage)._toGoRoute(rootKey, shellKey);
    }
    return (this as LayoutPage)._toShellRoute(rootKey);
  }
}

extension _SinglePageExtensions on SinglePage {
  GoRoute _toGoRoute(
    GlobalKey<NavigatorState> rootKey,
    GlobalKey<NavigatorState>? shellKey,
  ) {
    return GoRoute(
      name: name,
      path: path,
      parentNavigatorKey: shellKey ?? rootKey,
      pageBuilder: (context, state) => _createPageBasedOnType(
        context,
        state,
        builder(context),
        type,
      ),
    );
  }
}

extension _LayoutPageExtensions on LayoutPage {
  ShellRoute _toShellRoute(GlobalKey<NavigatorState> rootKey) {
    final shellKey = GlobalKey<NavigatorState>();
    return ShellRoute(
      navigatorKey: shellKey,
      pageBuilder: (context, state, child) => _createPageBasedOnType(
        context,
        state,
        builder(context, child),
        type,
      ),
      routes: childPages
          .map(
            (delegate) => delegate._toRoute(rootKey, shellKey),
          )
          .toList(growable: false),
    );
  }
}

extension _ErrorPageExtensions on ErrorPage {
  Page<dynamic> _toPage(BuildContext context, GoRouterState state) {
    return _createPageBasedOnType(
      context,
      state,
      builder(context, state.error),
      type,
    );
  }
}

/// A method to consolidate page creation based on the PageType.
Page<dynamic> _createPageBasedOnType(
  BuildContext context,
  GoRouterState state,
  Widget childWidget,
  PageType type,
) {
  // PageScope creation to wrap around the child widget.
  final pageScope = PageScope(
    cache: context.app.cache,
    name: state.matchedLocation,
    path: state.uri.toString(),
    pathParams: state.pathParameters,
    queryParams: state.uri.queryParameters,
    logger: context.app.logger,
    child: childWidget,
  );

  // Set the page in analytics
  context.app.analytics.setPage(
    state.matchedLocation,
    childWidget.runtimeType.toString(),
  );

  // Return the appropriate page based on the type
  switch (type) {
    case PageType.auto:
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        return CupertinoPage(child: pageScope);
      }
      return MaterialPage(child: pageScope);
    case PageType.material:
      return MaterialPage(child: pageScope);
    case PageType.cupertino:
      return CupertinoPage(child: pageScope);
    case PageType.noTransition:
      return NoTransitionPage(child: pageScope);
  }
}
