// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/_core/router.dart';
import 'package:feature_products/_core/router.dart';

import '../_core/super/_core/modal/modal_builder.dart';
import 'guard.dart';
import 'router.gr.dart';

@AutoRouterConfig(
  modules: [
    AuthFeatureRouter,
    ProductsFeatureRouter,
  ],
)
class FeaturesRouter extends $FeaturesRouter {
  FeaturesRouter();

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(
          page: SuperHandler.page,
          initial: true,
          children: [
            CupertinoRoute(
              page: DashboardRoute.page,
              guards: [AuthGuard()],
              initial: true,
              children: [
                CupertinoRoute(
                  page: HomeRouter.page,
                  children: [
                    CupertinoRoute(
                      title: (_, __) => $.tr.core.permissions.dialog.buttons.openSettings,
                      path: 'home',
                      page: HomeRoute.page,
                      initial: true,
                    ),
                    CupertinoRoute(
                      title: (_, __) => 'Fonts',
                      path: 'fonts',
                      page: FontsRoute.page,
                    ),
                  ],
                ),
                CupertinoRoute(title: (_, __) => 'Settings', path: 'settings', page: SettingsRoute.page),
              ],
            ),
            CupertinoRoute(
              title: (_, __) => 'Login',
              path: 'login',
              page: LoginRoute.page,
            ),
            CustomRoute(
              path: 'dialog',
              page: DialogWrapperRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              customRouteBuilder: modalRouteBuilder,
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
