import 'package:auto_route/auto_route.dart';
import 'package:flutter_advanced_boilerplate/utils/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          page: AppWrapper.page,
          path: '/',
          children: [
            AutoRoute(page: LoginRoute.page, path: 'home'),
            AutoRoute(page: AppNavigator.page, path: 'home'),
          ],
        ),
      ];
}
