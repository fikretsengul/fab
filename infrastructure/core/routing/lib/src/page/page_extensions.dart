// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/go_router.dart';
import 'package:flutter/material.dart';

import '../../routing.dart';
import '../helpers.dart';

/// Extension on `PageDelegate` to provide conversion to GoRouter's `RouteBase`.
extension PageDelegateExtensions on PageDelegate {
  /// Converts the `PageDelegate` into a `RouteBase` object suitable for GoRouter.
  /// The conversion is based on the specific type of `PageDelegate`.
  RouteBase toRoute(
    GlobalKey<NavigatorState> rootKey,
    GlobalKey<NavigatorState>? shellKey,
  ) {
    if (this is CustomPage) {
      return (this as CustomPage).toGoRoute(rootKey, shellKey);
    } else if (this is LayoutPage) {
      return (this as LayoutPage).toShellRoute(rootKey);
    }

    // For StatefulLayoutPage conversion.
    return (this as StatefulLayoutPage).toStatefulShellRoute(rootKey);
  }
}

/// Extension on `SinglePage` to provide conversion to GoRouter's `GoRoute`.
extension CustomPageExtensions on CustomPage {
  /// Converts a `SinglePage` into a `GoRoute`.
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
        builder(context, state),
        type,
      ),
      routes: pages.map((page) => page.toRoute(rootKey, shellKey)).toList(),
    );
  }
}

/// Extension on `LayoutPage` to provide conversion to GoRouter's `ShellRoute`.
extension LayoutPageExtensions on LayoutPage {
  /// Converts a `LayoutPage` into a `ShellRoute`.
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
      routes: pages.map((delegate) => delegate.toRoute(rootKey, shellKey)).toList(growable: false),
    );
  }
}

/// Extension on `StatefulLayoutPage` for internal route conversion.
extension StatefulLayoutPageExtensions on StatefulLayoutPage {
  /// Converts a `StatefulLayoutPage` into a `StatefulShellRoute`.
  StatefulShellRoute toStatefulShellRoute(GlobalKey<NavigatorState> rootKey) {
    final branches = this.branches.entries.map((entry) {
      final branchKey = entry.key;
      final branchRoutes = entry.value.map((page) => page.toRoute(rootKey, branchKey)).toList();

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

/// Extension on `ErrorPage` to provide a method for creating a `Page<dynamic>`.
extension ErrorPageExtensions on ErrorPage {
  /// Converts an `ErrorPage` into a `Page<dynamic>` for GoRouter.
  Page<dynamic> toPage(BuildContext context, GoRouterState state) {
    return createPageBasedOnType(
      context,
      state,
      builder(context, state.error),
      type,
    );
  }
}
