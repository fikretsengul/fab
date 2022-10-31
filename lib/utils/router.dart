import 'package:auto_route/auto_route.dart';
import 'package:flutter_advanced_boilerplate/features/auth/presentation/login_screen.dart';
import 'package:flutter_advanced_boilerplate/features/main_navigator.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: LoginScreen, initial: true),
    MaterialRoute(page: MainNavigator),
  ],
)
class $AppRouter {}
