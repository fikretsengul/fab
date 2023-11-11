import 'package:deps/packages/dio.dart';
import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import './configure_di.config.dart';

@InjectableInit(initializerName: 'init')
void configureDependencies(GetIt di, String env) {
  di.init(environment: env);
}

@module
abstract class DioModule {
  Dio get dio => Dio();
}

@module
abstract class InternetConnectionModule {
  InternetConnection get internetConnection => InternetConnection();
}
