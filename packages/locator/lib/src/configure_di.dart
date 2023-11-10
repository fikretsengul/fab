import 'package:analytics/analytics.dart' as analytics;
import 'package:auth/auth.dart' as auth;
import 'package:commons/commons.dart' as commons;
import 'package:deps/get_it.dart';
import 'package:deps/injectable.dart';
import 'package:networking/networking.dart' as networking;
import 'package:storage/storage.dart' as storage;

import 'configure_di.config.dart';

final GetIt di = GetIt.instance;

@InjectableInit(initializerName: 'init')
void initLocator(String env) {
  /// Configures core packages
  analytics.configuredeps(di, env);
  commons.configuredeps(di, env);
  networking.configuredeps(di, env);
  storage.configuredeps(di, env);

  /// Configures features
  auth.configuredeps(di, env);

  /// Inits injection
  di.init(environment: env);
}
