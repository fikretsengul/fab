// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_unused_parameters

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'material_modal_wrapper.dart';

Route<T> materialModalRouteBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
  if (page.child is! MaterialModalWrapperRoute) {
    throw ArgumentError('Child page must be of type MaterialModalWrapperRoute to use materialModalRouteBuilder.');
  }

  final dialogWrapperRoute = page.child as MaterialModalWrapperRoute;
  final config = dialogWrapperRoute.modalConfig;

  final isDismissible = config.isDismissible;
  final enableDrag = isDismissible && config.enableDrag;

  return ModalBottomSheetRoute<T>(
    settings: page,
    builder: (_) => child,
    capturedThemes: config.capturedThemes,
    barrierLabel: config.barrierLabel,
    barrierOnTapHint: config.barrierOnTapHint,
    backgroundColor: config.backgroundColor,
    elevation: config.elevation,
    shape: config.shape,
    clipBehavior: config.clipBehavior,
    constraints: config.constraints,
    modalBarrierColor: config.modalBarrierColor,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    showDragHandle: enableDrag,
    isScrollControlled: config.isScrollControlled,
    scrollControlDisabledMaxHeightRatio: config.scrollControlDisabledMaxHeightRatio,
    transitionAnimationController: config.transitionAnimationController,
    anchorPoint: config.anchorPoint,
    useSafeArea: config.useSafeArea,
  );
}
