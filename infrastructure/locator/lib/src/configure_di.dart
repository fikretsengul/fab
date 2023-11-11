import 'package:deps/core/analytics/analytics.dart' as analytics;
import 'package:deps/core/commons/commons.dart' as commons;
import 'package:deps/core/networking/networking.dart' as networking;
import 'package:deps/core/storage/storage.dart' as storage;
import 'package:deps/core/theming/theming.dart' as theming;
import 'package:deps/features/auth.dart' as auth;
import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';

import 'configure_di.config.dart';

final GetIt di = GetIt.instance;

@InjectableInit(initializerName: 'init')
void initLocator(String env) {
  /// Configures core packages
  analytics.configureDependencies(di, env);
  commons.configureDependencies(di, env);
  networking.configureDependencies(di, env);
  storage.configureDependencies(di, env);
  theming.configureDependencies(di, env);

  /// Configures features
  auth.configureDependencies(di, env);

  /// Inits injection
  di.init(environment: env);
}
