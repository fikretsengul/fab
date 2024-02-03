// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/_core/router.dart';
import 'package:feature_products/_core/router.dart';
import 'package:flutter/material.dart';

import '../_core/super/_core/dialog/cupertino/cupertino_dialog_builder.dart';
import '../_core/super/_core/dialog/material/material_dialog_builder.dart';
import '../_core/super/_core/modal/modal_builder.dart';
import '../_core/super/_core/sheet/cupertino/cupertino_sheet_builder.dart';
import 'guard.dart';
import 'router.gr.dart';

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required super.settings});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}

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
  RouteType get defaultRouteType => RouteType.custom(
        customRouteBuilder: <T>(
          context,
          child,
          page,
        ) {
          return CustomPageRoute<T>(
            settings: page,
            builder: (context) {
              return child;
            },
          );
        },
        durationInMilliseconds: 2500,
        reverseDurationInMilliseconds: 2500,
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SuperHandler.page,
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRouter.page,
              guards: [AuthGuard()],
              initial: true,
              children: [
                AutoRoute(
                  page: ProductsRouter.page,
                  children: [
                    AutoRoute(
                      title: (_, __) => $.tr.products.title,
                      path: 'products',
                      page: ProductsRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      path: 'product:id',
                      page: ProductDetailsRoute.page,
                    ),
                  ],
                ),
                AutoRoute(
                  title: (_, __) => $.tr.settings.title,
                  path: 'settings',
                  page: SettingsRoute.page,
                ),
              ],
            ),
            AutoRoute(
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
