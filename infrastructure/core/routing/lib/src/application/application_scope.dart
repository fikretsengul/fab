// ignore_for_file: avoid_returning_widgets

import 'package:deps/core/analytics/analytics.dart';
import 'package:deps/core/analytics/logger.dart';
import 'package:deps/core/storage/cache.dart';
import 'package:flutter/material.dart' hide Router;

import '../router/router.dart';

/// Application level scope that provides everything the entire application will
/// ever need. This scope does not change until the app is killed and reloaded.
/// This is also the root of the application (comes before [MaterialApp] or even
/// [WidgetsApp]).
@immutable
class ApplicationScope extends InheritedWidget {
  const ApplicationScope({
    required this.analytics,
    required this.cache,
    required this.logger,
    required this.router,
    required super.child,
    this.persistent,
    super.key,
  });

  final Analytics analytics;
  final ICache cache;
  final Logger logger;
  final ICache? persistent;
  final Router router;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static ApplicationScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }
}

/// Extensions for Pages
extension AppScopeExtensions on BuildContext {
  ApplicationScope get app => ApplicationScope.of(this);
  Logger get logger => ApplicationScope.of(this).logger;

  /// Route to a page by name.
  void to(
    String name, {
    Map<String, String> pathParams = const {},
    Map<String, dynamic> queryParams = const {},
  }) {
/*     page.logger.i('Attempting to route to $name...'); */
    app.router.route(
      this,
      name,
      pathParams: pathParams,
      queryParams: queryParams,
    );
  }
}
