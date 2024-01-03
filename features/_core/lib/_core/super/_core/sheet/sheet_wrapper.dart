import 'package:flutter/material.dart';

class SheetWrapper extends StatelessWidget {
  const SheetWrapper({
    required this.builder,
    this.canPop = true,
    this.onPop,
    super.key,
  });

  final bool canPop;
  final VoidCallback? onPop;
  final Widget Function(BuildContext context) builder;

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
        child: builder(context),
      ),
    );
  }
}
