import 'package:auto_route/auto_route.dart';
import 'package:flutter_advanced_boilerplate/features/main_navigator.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: MainNavigator, initial: true),
  ],
)
class $AppRouter {}
