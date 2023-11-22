import 'package:flutter/material.dart';

import '../others/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    required this.child,
    super.key,
    this.enable = true,
    this.baseColor,
    this.highlightColor,
  });

  final Widget child;
  final bool enable;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    if (enable) {
      return Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: highlightColor ?? Colors.grey.shade100,
        enabled: enable,
        child: child,
      );
    }

    return child;
  }
}
