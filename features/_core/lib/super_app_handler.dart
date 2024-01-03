import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'super/super.dart';

@RoutePage()
class SuperAppHandler extends StatelessWidget {
  const SuperAppHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: $.navigator.autoRouterKey,
      navigatorKey: $.navigator.navigatorKey,
      builder: (_, content) {
        return Scaffold(
          key: $.navigator.scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: content,
        );
      },
    );
  }
}
