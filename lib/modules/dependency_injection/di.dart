import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<GetIt> configureDependencyInjection() async => $initGetIt(getIt);
