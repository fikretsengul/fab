import 'package:deps/dio.dart';
import 'package:deps/get_it.dart';
import 'package:deps/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import './configure_di.config.dart';

@InjectableInit(initializerName: 'init')
void configuredeps(GetIt di, String env) {
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
