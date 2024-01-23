// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'material_dialog_wrapper.dart';

Route<T> materialDialogRouteBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
  if (page.child is! MaterialDialogWrapperRoute) {
    throw ArgumentError('Child page must be of type MaterialDialogWrapperRoute to use materialDialogRouteBuilder.');
  }

  final dialogWrapperRoute = page.child as MaterialDialogWrapperRoute;
  final config = dialogWrapperRoute.dialogConfig;

  return DialogRoute<T>(
    settings: page,
    context: context,
    builder: (_) => child,
    themes: config.themes,
    barrierColor: config.barrierColor,
    barrierDismissible: config.barrierDismissible,
    barrierLabel: config.barrierLabel,
    useSafeArea: config.useSafeArea,
    anchorPoint: config.anchorPoint,
    traversalEdgeBehavior: config.traversalEdgeBehavior,
  );
}
