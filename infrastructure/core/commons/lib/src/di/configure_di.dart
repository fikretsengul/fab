import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';

import './configure_di.config.dart';

@InjectableInit(initializerName: 'init')
void configureDependencies(GetIt di, String env) {
  di.init(environment: env);
}
