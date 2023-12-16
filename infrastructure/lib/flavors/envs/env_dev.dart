// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/envied.dart';
import 'package:deps/packages/injectable.dart';

import 'i_env.dart';

part 'env_dev.g.dart';

/// `EnvDev` is a concrete implementation of the `IEnv` interface for the development environment.
/// It uses the `envied` package to load environment variables from a `.env.dev` file.
///
/// This class is annotated for dependency injection as a singleton that implements `IEnv`.
/// It provides specific values for the development environment, such as API URLs and debug flags.
@Environment('dev')
@Singleton(as: IEnv)
@Envied(path: '../.env.dev')
class EnvDev implements IEnv {
  /// The analytics URL loaded from an environment variable.
  /// Points to the analytics service specific to the development environment.
  @override
  @EnviedField(varName: 'API_URL')
  final String analyticsUrl = _EnvDev.analyticsUrl;

  /// The API URL loaded from an environment variable.
  /// Points to the development backend service.
  @override
  @EnviedField(varName: 'ANALYTICS_URL')
  final String apiUrl = _EnvDev.apiUrl;

  /// Flag indicating the application is in debug mode.
  /// Set to `true` for the development environment to enable debugging features.
  @override
  final bool isDebug = true;
}
