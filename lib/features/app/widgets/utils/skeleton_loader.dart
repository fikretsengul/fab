import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:shimmer/shimmer.dart';

enum SkeletonDirection { ltr, rtl, ttb, btt }

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    super.key,
    required this.child,
    this.isActive = true,
    this.baseColor,
    this.highlightColor,
    this.direction = SkeletonDirection.ltr,
    this.period = const Duration(seconds: 2),
  });

  final Color? baseColor;
  final Widget child;
  final SkeletonDirection direction;
  final Color? highlightColor;
  final bool isActive;
  final Duration period;

  ShimmerDirection getDirection(SkeletonDirection skDirection) {
    ShimmerDirection direction;
    switch (skDirection) {
      case SkeletonDirection.ltr:
        direction = ShimmerDirection.ltr;
        break;
      case SkeletonDirection.rtl:
        direction = ShimmerDirection.rtl;
        break;
      case SkeletonDirection.btt:
        direction = ShimmerDirection.btt;
        break;
      case SkeletonDirection.ttb:
        direction = ShimmerDirection.ttb;
        break;
    }

    return direction;
  }

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      final directionn = getDirection(direction);

      return Shimmer.fromColors(
        baseColor: baseColor ?? getTheme(context).primary.withOpacity(0.1),
        highlightColor: highlightColor ?? getTheme(context).primary.withOpacity(0.2),
        direction: directionn,
        period: period,
        child: child,
      );
    } else {
      return child;
    }
  }
}
