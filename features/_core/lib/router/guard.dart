import 'dart:async';

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/core/routes/router.gm.dart';

import '../super/super.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard() {
    $.get<INetworkClient>().tokenStorage.authStatus.listen((_) {
      $.navigator.reevaluateGuards();
    });
  }

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final completer = Completer<AuthStatus>();

    $.get<INetworkClient>().tokenStorage.authStatus.listen((status) {
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
