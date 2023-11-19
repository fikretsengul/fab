// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/go_router.dart';
import 'package:flutter/widgets.dart';

import '../enums.dart';

typedef PageWidgetBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

/// A type alias for a builder function that creates a widget for error pages.
/// Receives a context and an optional error object.
typedef ErrorPageWidgetBuilder = Widget Function(
  BuildContext context,
  Exception? error,
);

/// A type alias for a builder function that creates a layout widget.
/// Receives a context and a child widget.
typedef LayoutPageWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// A type alias for a stateful builder function for layout pages.
/// Receives a context, state, and navigation shell for stateful layouts.
typedef StatefulLayoutPageWidgetBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
  StatefulNavigationShell navigationShell,
);

/// Base class for defining page delegates, providing a structure for routing.
abstract class PageDelegate {
  /// Constructs a `PageDelegate` with a given page type and child routes.
  PageDelegate({
    required this.type,
    required this.routes,
  });

  /// The type of the page, determining its behavior in the routing system.
  final PageType type;

  /// Child routes that can be navigated to from this page.
  final List<PageDelegate> routes;
}

/// Represents a single page in the routing system.
class CustomPage extends PageDelegate {
  /// Constructs a `SinglePage` with a specific destination, and widget builder.
  CustomPage({
    required this.name,
    required this.path,
    required this.builder,
    this.pages = const [],
    PageType? type,
  }) : super(type: type ?? PageType.auto, routes: pages);

  /// The builder function to create the widget for this page.
  final PageWidgetBuilder builder;

  /// The unique name for this page.
  final String name;

  /// The path associated with this page.
  final String path;

  /// Child routes that can be navigated to from this page.
  final List<PageDelegate> pages;
}

/// Represents a layout page that can host other pages.
class LayoutPage extends PageDelegate {
  /// Constructs a `LayoutPage` with a layout builder and child pages.
  LayoutPage({
    required this.builder,
    required this.pages,
    PageType? type,
  }) : super(type: type ?? PageType.auto, routes: pages);

  /// The builder function to create the layout widget.
  final LayoutPageWidgetBuilder builder;

  /// The list of child pages within this layout.
  final List<PageDelegate> pages;
}

/// Represents a stateful layout page that maintains the state of its child pages.
class StatefulLayoutPage extends PageDelegate {
  /// Constructs a `StatefulLayoutPage` with a stateful layout builder and branch routes.
  StatefulLayoutPage({
    required this.builder,
    required this.branches,
    PageType? type,
  }) : super(type: type ?? PageType.auto, routes: branches.values.expand((b) => b).toList());

  /// The builder function for creating a stateful layout widget.
  final StatefulLayoutPageWidgetBuilder builder;

  /// Branches, each with a list of `PageDelegate`, for stateful navigation.
  final Map<GlobalKey<NavigatorState>?, List<PageDelegate>> branches;
}

/// Represents an error page in the routing system.
class ErrorPage extends PageDelegate {
  /// Constructs an `ErrorPage` with a specific name, path, and error builder.
  ErrorPage({
    required this.name,
    required this.path,
    required this.builder,
    PageType? type,
  }) : super(type: type ?? PageType.auto, routes: []);

  /// The builder function to create the error page widget.
  final ErrorPageWidgetBuilder builder;

  /// The unique name for this error page.
  final String name;

  /// The path associated with this error page.
  final String path;
}
