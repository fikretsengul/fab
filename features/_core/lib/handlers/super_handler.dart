// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import '../_core/super/super.dart';

@RoutePage()
class SuperHandler extends StatefulWidget {
  const SuperHandler({super.key});

  @override
  State<SuperHandler> createState() => _SuperHandlerState();
}

class _SuperHandlerState extends State<SuperHandler> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add((_, __) => shouldIntercept());
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove((_, __) => shouldIntercept());
    super.dispose();
  }

  bool shouldIntercept() {
    if ($.dialog.hasDialogVisible) {
      $.dialog.popDialog();

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: $.navigator.autoRouterKey,
      navigatorKey: $.navigator.navigatorKey,
      builder: (_, child) {
        return Scaffold(
          key: $.navigator.scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: child,
        );
      },
    );
  }
}
