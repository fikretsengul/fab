// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../others/shimmer.dart';

/// A widget that applies a shimmer effect to its child.
///
/// The [ShimmerEffect] widget wraps a [child] with a shimmer animation effect,
/// commonly used as a placeholder for content loading states.
class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    required this.child,
    super.key,
    this.enable = true,
    this.baseColor,
    this.highlightColor,
  });

  /// The widget over which to apply the shimmer effect.
  final Widget child;

  /// Controls whether the shimmer effect is enabled.
  final bool enable;

  /// The base color of the shimmer. Defaults to a shade of grey if not provided.
  final Color? baseColor;

  /// The highlight color of the shimmer. Defaults to a lighter shade of grey if not provided.
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    // Apply shimmer effect if enabled, otherwise return the child directly.
    return enable
        ? Shimmer.fromColors(
            baseColor: baseColor ?? Colors.grey.shade300,
            highlightColor: highlightColor ?? Colors.grey.shade100,
            enabled: enable,
            child: child,
          )
        : child;
  }
}
