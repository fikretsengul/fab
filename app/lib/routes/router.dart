import 'package:deps/features/auth.dart';
import 'package:deps/packages/auto_route.dart';

import 'router.gr.dart';

Map<String, String> localizedRouteTitlesMap() => {
      DashboardRoute.name: 'Dashboard',
      HomeRoute.name: 'Home',
      SettingsRoute.name: 'Settings',
      FontsRoute.name: 'Fonts',
    };

@AutoRouterConfig(
  modules: [
    AuthFeatureRouter,
  ],
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: DashboardRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: HomeRouter.page,
              children: [
                AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
                AutoRoute(path: 'fonts', page: FontsRoute.page),
              ],
            ),
            AutoRoute(path: 'settings', page: SettingsRoute.page),
          ],
        ),
        AutoRoute(path: '/login', page: LoginRoute.page),
      ];
}
