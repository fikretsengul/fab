// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// `RouteInfo` class holds essential details about a specific route in the application.
/// It includes the route's path and any relevant parameters for dynamic routing and queries.
class RouteInfo {
  /// Constructs a `RouteInfo` instance with necessary route details.
  ///
  /// [path]: The path of the route, typically a URL-like string.
  /// [pathParams]: A map of path parameters, where keys are parameter names
  ///               and values are the corresponding parameter values.
  /// [queryParams]: A map of query parameters for the route, similar to URL query strings.
  RouteInfo({
    required this.path,
    required this.pathParams,
    required this.queryParams,
  });

  /// The path of the route, representing the routing endpoint.
  final String path;

  /// Path parameters for the route, useful for dynamic routing scenarios
  /// where specific segments of the route path are variable.
  final Map<String, String> pathParams;

  /// Query parameters for the route, providing additional options or filters
  /// that can modify how the route should be handled or what content should be shown.
  final Map<String, String> queryParams;
}
