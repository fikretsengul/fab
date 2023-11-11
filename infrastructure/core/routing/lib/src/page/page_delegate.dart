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

/// Base class for page delegates, providing
/// the core properties and behavior.
abstract class PageDelegate {
  PageDelegate({
    required this.type,
    required this.nestedPages,
  });

  /// Child pages that can be navigated to from the current page.
  final List<PageDelegate> nestedPages;

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
  }) : super(type: type ?? PageType.auto, nestedPages: []);

  final WidgetBuilder builder;
  final String name;
  final String path;
}

/// Represents a layout page that can host other navigable pages.
class LayoutPage extends PageDelegate {
  LayoutPage({
    required this.builder,
    required this.childPages,
    PageType? type,
  }) : super(type: type ?? PageType.auto, nestedPages: childPages);

  final LayoutPageWidgetBuilder builder;
  final List<PageDelegate> childPages;
}

/// Represents an error page with a specific name, path, and error builder.
class ErrorPage extends PageDelegate {
  ErrorPage({
    required this.name,
    required this.path,
    required this.builder,
    PageType? type,
  }) : super(type: type ?? PageType.auto, nestedPages: []);

  final ErrorPageWidgetBuilder builder;
  final String name;
  final String path;
}
