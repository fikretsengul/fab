// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';

import './_di.config.dart';

/// Initializes the authentication feature's dependencies.
///
/// This function sets up the dependency injection for the user feature
/// of the application using [GetIt] as the service locator.
///
/// [env] is a string representing the current environment (e.g., development, production).
@InjectableInit(initializerName: 'init')
void injectUserFeature(GetIt di, String env) {
  di.init(environment: env);
}
