// Source: https://github.com/Kavantix/sliver_tools
// Last updated at https://github.com/Kavantix/sliver_tools/commit/ee06da0f026bbba09cf314f1877e7fe5c312c971

import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

part 'rendering.dart';

/// [MultiSliver] allows for returning multiple slivers from a single build method
class MultiSliver extends MultiChildRenderObjectWidget {
  // flutter pre 3.13 does not allow the constructor to be const
  // ignore: prefer_const_constructors_in_immutables
  MultiSliver({
    required super.children,
    super.key,
    this.pushPinnedChildren = false,
  });

  /// If true any children that paint beyond the layoutExtent of the entire [MultiSliver] will
  /// be pushed off towards the leading edge of the [Viewport]
  final bool pushPinnedChildren;

  @override
  RenderMultiSliver createRenderObject(BuildContext context) => RenderMultiSliver(
        containing: pushPinnedChildren,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderMultiSliver renderObject,
  ) {
    renderObject.containing = pushPinnedChildren;
  }
}
