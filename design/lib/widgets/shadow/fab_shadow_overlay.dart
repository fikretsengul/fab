import 'package:deps/features/features.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/fab_theme.dart';

class FabGradientShadow extends StatelessWidget {
  const FabGradientShadow({
    required this.child,
    required this.shadowHeight,
    this.shadowWidth,
    this.enabled = true,
    super.key,
    this.shadowColor,
  });

  final bool enabled;
  final Widget child;
  final double shadowHeight;
  final double? shadowWidth;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final color = shadowColor ?? context.fabTheme.surfaceColor;

    return Stack(
      children: [
        child,
        Positioned(
          bottom: -1,
          child: AnimatedOpacity(
            opacity: enabled ? 1 : 0,
            duration: $.timings.mil400,
            child: Container(
              height: shadowHeight,
              width: shadowWidth ?? context.mqWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [color, color.withOpacity(0)],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
