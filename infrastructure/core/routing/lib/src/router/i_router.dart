// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// `IRouter` is an abstract interface defining the contract for a routing system.
/// It specifies the methods and properties that any router implementation should provide
/// for navigation within a Flutter application.
abstract interface class IRouter {
  /// The router configuration, defining how routes are structured and managed.
  /// This configuration should encapsulate all routing logic and behavior.
  RouterConfig<Object> get config;

  /// Navigates to a named route within the application.
  ///
  /// [context]: The `BuildContext` used to navigate.
  /// [name]: The name of the route to navigate to.
  /// [pathParams]: Optional path parameters for dynamic routing.
  /// [queryParams]: Optional query parameters for the route.
  ///
  /// This method should handle the navigation logic, utilizing the provided
  /// route name and parameters to determine the destination.
  void route(
    BuildContext context,
    String name, {
    Map<String, String> pathParams,
    Map<String, dynamic> queryParams,
  });
}
