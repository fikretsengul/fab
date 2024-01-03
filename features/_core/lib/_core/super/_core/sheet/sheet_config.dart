import 'package:flutter/material.dart';

class SheetConfig {
  const SheetConfig({
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.enableDrag = true,
    this.transitionAnimationController,
  });

  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final bool enableDrag;
  final AnimationController? transitionAnimationController;
}
