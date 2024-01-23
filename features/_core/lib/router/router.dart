// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/_core/router.dart';
import 'package:feature_products/_core/router.dart';

import '../_core/super/_core/dialog/cupertino/cupertino_dialog_builder.dart';
import '../_core/super/_core/dialog/material/material_dialog_builder.dart';
import '../_core/super/_core/modal/modal_builder.dart';
import '../_core/super/_core/sheet/cupertino/cupertino_sheet_builder.dart';
import 'guard.dart';
import 'router.gr.dart';

@AutoRouterConfig(
  modules: [
    AuthFeatureRouter,
    ProductsFeatureRouter,
    SettingsFeatureRouter,
    UserFeatureRouter,
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
              page: DashboardRouter.page,
              guards: [AuthGuard()],
              initial: true,
              children: [
                CupertinoRoute(
                  page: ProductsRouter.page,
                  children: [
                    CupertinoRoute(
                      title: (_, __) => $.tr.products.title,
                      path: 'products',
                      page: ProductsRoute.page,
                      initial: true,
                    ),
                    CupertinoRoute(
                      path: 'product:id',
                      page: ProductDetailsRoute.page,
                    ),
                  ],
                ),
                CupertinoRoute(
                  title: (_, __) => $.tr.settings.title,
                  path: 'settings',
                  page: SettingsRoute.page,
                ),
              ],
            ),
            CupertinoRoute(
              title: (_, __) => $.tr.auth.title,
              path: 'login',
              page: LoginRoute.page,
            ),
            CustomRoute(
              page: MaterialDialogWrapperRoute.page,
              customRouteBuilder: materialDialogRouteBuilder,
            ),
            CustomRoute(
              page: CupertinoDialogWrapperRoute.page,
              customRouteBuilder: cupertinoDialogRouteBuilder,
            ),
            CustomRoute(
              page: CupertinoSheetWrapperRoute.page,
              customRouteBuilder: cupertinoSheetRouteBuilder,
            ),
            CustomRoute(
              page: ModalWrapperRoute.page,
              customRouteBuilder: modalRouteBuilder,
            ),
          ],
        ),
      ];
}
