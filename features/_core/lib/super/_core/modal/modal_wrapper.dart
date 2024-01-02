import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'modal_config.dart';

@RoutePage()
class ModalWrapperRoute extends StatelessWidget {
  const ModalWrapperRoute({
    required this.builder,
    this.modalConfig = const ModalConfig(),
    this.canPop = true,
    this.onPop,
    super.key,
  });

  final bool canPop;
  final VoidCallback? onPop;
  final Widget Function(BuildContext context) builder;
  final ModalConfig modalConfig;

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
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: builder(context),
      ),
    );
  }
}
