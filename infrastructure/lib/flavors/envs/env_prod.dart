// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/envied.dart';
import 'package:deps/packages/injectable.dart';

import 'i_env.dart';

part 'env_prod.g.dart';

/// `EnvProd` is a concrete implementation of the `IEnv` interface for the production environment.
/// It uses the `envied` package to load environment variables from a `.env.prod` file.
///
/// This class is annotated for dependency injection as a singleton that implements `IEnv`.
/// It provides specific values for the production environment, such as API URLs.
/// Note that the debug flag is set to true here, which might need to be changed
/// based on the actual requirements of the production environment.
@Environment('prod')
@Singleton(as: IEnv)
@Envied(path: '../.env.prod')
class EnvProd implements IEnv {
  /// The analytics URL loaded from an environment variable.
  /// Points to the analytics service specific to the production environment.
  @override
  @EnviedField(varName: 'API_URL')
  final String analyticsUrl = _EnvProd.analyticsUrl;

  /// The API URL loaded from an environment variable.
  /// Points to the production backend service.
  @override
  @EnviedField(varName: 'ANALYTICS_URL')
  final String apiUrl = _EnvProd.apiUrl;

  /// Flag indicating the application is in debug mode.
  /// Typically, this should be `false` for production, but it's set to `true` here.
  /// This should be adjusted based on production environment requirements.
  @override
  final bool isDebug = true;
}
