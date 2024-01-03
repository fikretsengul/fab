import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'dialog_config.dart';

@RoutePage()
class DialogWrapperRoute extends StatelessWidget {
  const DialogWrapperRoute({
    required this.builder,
    this.dialogConfig = const DialogConfig(),
    this.canPop = true,
    this.onPop,
    super.key,
  });

  final bool canPop;
  final VoidCallback? onPop;
  final Widget Function(BuildContext context) builder;
  final DialogConfig dialogConfig;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        onPop?.call();
      },
      child: builder(context),
    );
  }
}
