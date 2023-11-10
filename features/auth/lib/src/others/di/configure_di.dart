import 'package:deps/get_it.dart';
import 'package:deps/injectable.dart';

import './configure_di.config.dart';

@InjectableInit(initializerName: 'init')
void configuredeps(GetIt di, String env) {
  di.init(environment: env);
}
