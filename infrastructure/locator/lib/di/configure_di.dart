// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/core/analytics/analytics.dart' as analytics;
import 'package:deps/core/flavors/flavors.dart' as flavors;
import 'package:deps/core/networking/networking.dart' as networking;
import 'package:deps/core/storage/storages.dart' as storage;
import 'package:deps/core/theming/theming.dart' as theming;
import 'package:deps/features/auth.dart' as auth;
import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';

import 'configure_di.config.dart';

final GetIt di = GetIt.instance;

/// Initializes the service locator (`GetIt`) with dependency configurations for various modules and features.
///
/// This function is responsible for setting up and initializing the dependency injection system
/// for the application. It ensures that all dependencies are properly registered and available
/// for use throughout the app.
///
/// [env]: A string representing the current environment (e.g., 'dev', 'prod').
@InjectableInit(initializerName: 'init')
void initLocator(String env) {
  /// Configures core packages like analytics, flavors, networking, storage, and theming.
  /// Each package has its own configuration method that registers its dependencies with GetIt.
  analytics.configureDependencies(di, env);
  flavors.configureDependencies(di, env);
  networking.configureDependencies(di, env);
  storage.configureDependencies(di, env);
  theming.configureDependencies(di, env);

  /// Configures feature-specific dependencies, such as authentication.
  auth.configureDependencies(di, env);

  /// Initializes dependency injection with the configured environment.
  di.init(environment: env);
}
