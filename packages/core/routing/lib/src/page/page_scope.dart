import 'package:analytics/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:storage/cache.dart';

/// A scope that represents the available resources within a Page.
@immutable
class PageScope extends InheritedWidget {
  const PageScope({
    required this.cache,
    required this.logger,
    required this.name,
    required this.path,
    required this.pathParams,
    required this.queryParams,
    required super.child,
    super.key,
  });

  /// Page's cached memory Use this to help share data
  /// between Widgets within the Page.
  final ICache cache;

  /// Page's logging interface.
  final Logger logger;

  /// Name of current page.
  final String name;

  /// Current Page path.
  final String path;

  /// Required parameters of the page.
  final Map<String, String> pathParams;

  /// Additional parameters from the route to this page.
  final Map<String, String> queryParams;

  @override
  bool updateShouldNotify(covariant PageScope oldWidget) =>
      oldWidget.pathParams != pathParams ||
      oldWidget.queryParams != queryParams;

  static PageScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }
}

/// Extensions for Pages
extension PageExtensions on BuildContext {
  PageScope get page => PageScope.of(this);
}
