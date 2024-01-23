import 'dart:math' as math;

import 'package:deps/packages/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class Refresher extends StatelessWidget {
  Refresher({
    required this.topPadding,
    required this.refreshListenable,
    super.key,
  });

  final IndicatorStateListenable refreshListenable;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPadding + 52.0,
      child: ValueListenableBuilder<IndicatorState?>(
        valueListenable: refreshListenable,
        builder: (_, state, __) {
          if (state == null) {
            return const SizedBox.shrink();
          }

          final color = CupertinoTheme.of(context).primaryContrastingColor;
          final mode = state.mode;
          final offset = state.offset;
          final actualTriggerOffset = state.actualTriggerOffset;

          final offsetRatio = math.min<double>(offset / actualTriggerOffset, 1);
          final value = ((offsetRatio - 0.3) / 0.7).clamp(0.0, 1.0);

          Widget? widget;

          if (mode == IndicatorMode.drag) {
            widget = CupertinoActivityIndicator.partiallyRevealed(
              radius: 14,
              progress: value,
              color: color,
            );
          } else if (mode == IndicatorMode.armed || mode == IndicatorMode.ready) {
            widget = CupertinoActivityIndicator(radius: 14, color: color);
          } else {
            widget = const SizedBox.shrink();
          }

          return Opacity(opacity: value, child: widget);
        },
      ),
    );
  }
}
