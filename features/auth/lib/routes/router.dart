import 'package:deps/packages/auto_route.dart';

import 'router.gm.dart';

@AutoRouterConfig.module()
class AuthFeatureRouter extends $AuthFeatureRouter {
  final List<AutoRoute> routes = [
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
  ];
}
