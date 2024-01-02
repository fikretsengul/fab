import 'dart:async';

import 'package:deps/infrastructure/core.dart';
import 'package:deps/infrastructure/networking.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/core/routes/router.gm.dart';

import '../super/super.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard() {
    $.locator<INetworkClient>().tokenStorage.authStatus.listen((_) {
      $.navigator.reevaluateGuards();
    });
  }

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final completer = Completer<AuthStatus>();

    di<INetworkClient>().tokenStorage.authStatus.listen((status) {
      if (!completer.isCompleted && status != AuthStatus.initial) {
        completer.complete(status);
      }
    });

    final status = await completer.future;
    if (status == AuthStatus.authenticated) {
      resolver.next();
    } else {
      await resolver.redirect(LoginRoute(onResult: (didLogin) => resolver.next(didLogin)));
    }
  }
}
