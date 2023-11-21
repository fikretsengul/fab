// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_flutter.dart';

import './configure_di.config.dart';

/// Initializes and configures dependencies for the application.
///
/// This function sets up dependency injection using the [GetIt] locator
/// and the [injectable] package. It should be called at the start of the app
/// to ensure all dependencies are properly registered and available.
///
/// [di]: The [GetIt] instance used for dependency injection.
/// [env]: A string representing the current environment (e.g., 'dev', 'prod').
@InjectableInit(initializerName: 'init')
void configureDependencies(GetIt di, String env) {
  di.init(environment: env);
}

/// A module for providing instances of [Talker].
///
/// This module is used by the [injectable] package to generate code for
/// dependency injection. It defines how instances of [Talker] should be
/// created and provided. [Talker] is used for logging and debugging.
@module
abstract class TalkerModule {
  /// Provides a configured instance of [Talker].
  ///
  /// This method initializes and returns an instance of [TalkerFlutter],
  /// which can be used throughout the application for logging purposes.
  Talker talker() => TalkerFlutter.init();
}
