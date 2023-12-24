// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/flutter_secure_storage.dart';
import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/internet_connection_checker_plus.dart';
import 'package:deps/packages/talker_flutter.dart';

import '../analytics/logger/talker/formatter/fancy_talker_log_formatter.dart';
import '_di.config.dart';

part '_modules.dart';

/// Initializes the infrastructure dependencies.
///
/// This function sets up the dependency injection for the infrastructure layer of the application
/// using [GetIt] as the service locator.
///
/// [env] is a string representing the current environment (e.g., development, production).
@InjectableInit(initializerName: 'init')
void injectInfrastructure(GetIt di, String env) {
  di.init(environment: env);
}
