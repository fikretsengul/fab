// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:feature_auth/auth.dart';

import '../_core/super/super.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard() {
    $.get<INetworkClient>().tokenStorage.authStatus.listen((a) {
      print('amk');
      print(a);
      $.navigator.reevaluateGuards();
    });
  }

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final completer = Completer<AuthStatus>();

    $.get<INetworkClient>().tokenStorage.authStatus.listen((status) {
      print('bmk');
      print(status);
      if (!completer.isCompleted && status != AuthStatus.initial) {
        completer.complete(status);
      }
    });

    final status = await completer.future;
    if (status == AuthStatus.authenticated) {
      resolver.next();
    } else {
      await resolver.redirect(
        LoginRoute(
          onResult: (didLogin) => resolver.next(didLogin),
        ),
      );
    }
  }
}
