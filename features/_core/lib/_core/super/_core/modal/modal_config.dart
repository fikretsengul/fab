// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class ModalConfig {
  const ModalConfig({
    this.isScrollControlled = true,
    this.modalBarrierColor = Colors.black54,
    this.showDragHandle = true,
    this.capturedThemes,
    this.barrierLabel,
    this.barrierOnTapHint,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.isDismissible = true,
    this.enableDrag = true,
    this.scrollControlDisabledMaxHeightRatio = 0.7,
    this.settings,
    this.transitionAnimationController,
    this.anchorPoint,
    this.useSafeArea = false,
  });

  final bool isScrollControlled;
  final Color? modalBarrierColor;
  final bool showDragHandle;
  final CapturedThemes? capturedThemes;
  final String? barrierLabel;
  final String? barrierOnTapHint;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final bool isDismissible;
  final bool enableDrag;
  final double scrollControlDisabledMaxHeightRatio;
  final RouteSettings? settings;
  final AnimationController? transitionAnimationController;
  final Offset? anchorPoint;
  final bool useSafeArea;
}
