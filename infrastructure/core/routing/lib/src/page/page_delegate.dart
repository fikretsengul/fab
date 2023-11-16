import 'package:deps/packages/go_router.dart';
import 'package:flutter/widgets.dart';

import 'page_type.dart';

/// A type alias for a builder function that
/// receives a context and an error.
typedef ErrorPageWidgetBuilder = Widget Function(
  BuildContext context,
  Exception? error,
);

/// A type alias for a builder function that
/// receives a context and a child widget.
typedef LayoutPageWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// A type alias for a stateful builder function that
/// receives a context, state and navigation shell.
typedef StatefulLayoutPageWidgetBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
  StatefulNavigationShell navigationShell,
);

/// Base class for page delegates, providing
/// the core properties and behavior.
abstract class PageDelegate {
  PageDelegate({
    required this.type,
    required this.routes,
  });

  /// Child routes that can be navigated to from the current page.
  final List<PageDelegate> routes;

  /// Determines the type of the Page.
  final PageType type;
}

/// Represents a single page with a specific name and path.
class SinglePage extends PageDelegate {
  SinglePage({
    required this.name,
    required this.path,
    required this.builder,
    PageType? type,
  }) : super(
          type: type ?? PageType.auto,
          routes: [],
        );

  final WidgetBuilder builder;
  final String name;
  final String path;
}

/// Represents a layout page that can host other navigable pages.
class LayoutPage extends PageDelegate {
  LayoutPage({
    required this.builder,
    required this.pages,
    PageType? type,
  }) : super(
          type: type ?? PageType.auto,
          routes: pages,
        );

  final LayoutPageWidgetBuilder builder;
  final List<PageDelegate> pages;
}

/// Represents a stateful layout page that can persists state of other navigable pages.
class StatefulLayoutPage extends PageDelegate {
  StatefulLayoutPage({
    required this.builder,
    required this.branches,
    PageType? type,
  }) : super(
          type: type ?? PageType.auto,
          routes: branches.values.expand((b) => b).toList(),
        );

  final StatefulLayoutPageWidgetBuilder builder;
  // Map of GlobalKey<NavigatorState> to a list of PageDelegates for each branch
  final Map<GlobalKey<NavigatorState>?, List<PageDelegate>> branches;
}

/// Represents an error page with a specific name, path, and error builder.
class ErrorPage extends PageDelegate {
  ErrorPage({
    required this.name,
    required this.path,
    required this.builder,
    PageType? type,
  }) : super(
          type: type ?? PageType.auto,
          routes: [],
        );

  final ErrorPageWidgetBuilder builder;
  final String name;
  final String path;
}
