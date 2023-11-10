import 'package:deps/get_it.dart';
import 'package:deps/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './configure_di.config.dart';

@InjectableInit(initializerName: 'init')
void configuredeps(GetIt di, String env) {
  di.init(environment: env);
}

@module
abstract class FlutterSecureStorageModule {
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );
}
