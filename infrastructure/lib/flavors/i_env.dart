// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// `IEnv` is an abstract interface defining an environment configuration contract.
/// It provides properties essential for configuring and managing different
/// aspects of the application environment.
abstract interface class IEnv {
  /// The API URL of the backend service.
  /// This property holds the base URL for all network requests made by the application.
  abstract final String apiUrl;

  /// The URL for the analytics service.
  /// This property is used to configure the endpoint for sending analytics data.
  abstract final String analyticsUrl;

  /// A flag indicating whether the application is in debug mode.
  /// When set to `true`, the application may enable additional logging,
  /// debugging tools, or development features.
  abstract final bool isDebug;
}
