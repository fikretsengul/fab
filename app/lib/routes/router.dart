import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';

import 'router.gr.dart';

/* Map<String, String> localizedRouteTitlesMap() => {
      DashboardRoute.name: 'Dashboard',
      HomeRoute.name: 'Home',
      SettingsRoute.name: 'Settings',
      FontsRoute.name: 'Fonts',
    }; */

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
          guards: [AuthGuard()],
          children: [
            AutoRoute(
              page: HomeRouter.page,
              children: [
                AutoRoute(title: (_, __) => 'Home', path: 'home', page: HomeRoute.page, initial: true),
                AutoRoute(title: (_, __) => 'Fonts', path: 'fonts', page: FontsRoute.page),
              ],
            ),
            AutoRoute(title: (_, __) => 'Settings', path: 'settings', page: SettingsRoute.page),
          ],
        ),
        AutoRoute(title: (_, __) => 'Login', path: '/login', page: LoginRoute.page),
      ];
}
