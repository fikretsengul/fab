import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';

import '../_core/super/_core/dialog/dialog_builder.dart';
import '../_core/super/_core/modal/modal_builder.dart';
import 'guard.dart';
import 'router.gr.dart';

@AutoRouterConfig(
  modules: [
    AuthFeatureRouter,
  ],
)
class FeaturesRouter extends $FeaturesRouter {
  FeaturesRouter();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SuperHandler.page,
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              guards: [AuthGuard()],
              initial: true,
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
            AutoRoute(
              title: (_, __) => 'Login',
              path: 'login',
              page: LoginRoute.page,
            ),
            CustomRoute(
              path: 'dialog',
              page: DialogWrapperRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              customRouteBuilder: dialogRouteBuilder,
            ),
            CustomRoute(
              path: 'modal',
              page: ModalWrapperRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              customRouteBuilder: modalRouteBuilder,
            ),
          ],
        ),
      ];
}
