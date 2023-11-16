import 'package:deps/packages/go_router.dart';
import 'package:flutter/material.dart';

import '../../../page.dart';
import '../helpers/router_helpers.dart';

/// Extensions to provide route conversion methods for
/// PageDelegate, SinglePage, LayoutPage, and ErrorPage.
extension PageDelegateExtensions on PageDelegate {
  RouteBase toRoute(
    GlobalKey<NavigatorState> rootKey,
    GlobalKey<NavigatorState>? shellKey,
  ) {
    if (this is SinglePage) {
      return (this as SinglePage).toGoRoute(rootKey, shellKey);
    } else if (this is LayoutPage) {
      return (this as LayoutPage).toShellRoute(rootKey);
    }

    return (this as StatefulLayoutPage)._toStatefulShellRoute(rootKey);
  }
}

extension SinglePageExtensions on SinglePage {
  GoRoute toGoRoute(
    GlobalKey<NavigatorState> rootKey,
    GlobalKey<NavigatorState>? shellKey,
  ) {
    return GoRoute(
      name: name,
      path: path,
      parentNavigatorKey: shellKey ?? rootKey,
      pageBuilder: (context, state) => createPageBasedOnType(
        context,
        state,
        builder(context),
        type,
      ),
    );
  }
}

extension LayoutPageExtensions on LayoutPage {
  ShellRoute toShellRoute(GlobalKey<NavigatorState> rootKey) {
    final shellKey = GlobalKey<NavigatorState>();

    return ShellRoute(
      navigatorKey: shellKey,
      pageBuilder: (context, state, child) => createPageBasedOnType(
        context,
        state,
        builder(context, child),
        type,
      ),
      routes: pages
          .map(
            (delegate) => delegate.toRoute(rootKey, shellKey),
          )
          .toList(growable: false),
    );
  }
}

extension StatefulLayoutPageExtensions on StatefulLayoutPage {
  StatefulShellRoute _toStatefulShellRoute(GlobalKey<NavigatorState> rootKey) {
    final branches = this.branches.entries.map((entry) {
      final branchKey = entry.key;
      final branchRoutes = entry.value
          .map(
            (page) => page.toRoute(rootKey, branchKey),
          )
          .toList();

      return StatefulShellBranch(
        navigatorKey: branchKey,
        routes: branchRoutes,
      );
    }).toList();

    return StatefulShellRoute.indexedStack(
      builder: builder,
      branches: branches,
    );
  }
}

extension ErrorPageExtensions on ErrorPage {
  Page<dynamic> toPage(BuildContext context, GoRouterState state) {
    return createPageBasedOnType(
      context,
      state,
      builder(context, state.error),
      type,
    );
  }
}
