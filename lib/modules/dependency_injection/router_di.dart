import 'package:flutter_advanced_boilerplate/utils/router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterInjection {
  AppRouter router() => AppRouter();
}
