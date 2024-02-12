// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_unused_parameters

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'cupertino_modal_sheet_route.dart';
import 'cupertino_modal_wrapper.dart';

Route<T> cupertinoModalRouteBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
  if (page.child is! CupertinoModalWrapperRoute) {
    throw ArgumentError('Child page must be of type CupertinoModalWrapperRoute to use cupertinoModalRouteBuilder.');
  }

  final dialogWrapperRoute = page.child as CupertinoModalWrapperRoute;
  final config = dialogWrapperRoute.modalConfig;

  return CupertinoModalSheetRoute<T>(
    settings: page,
    enablePullToDismiss: config.enablePullToDismiss,
    maintainState: config.maintainState,
    barrierDismissible: config.barrierDismissible,
    barrierLabel: config.barrierLabel,
    barrierColor: config.barrierColor,
    transitionDuration: config.transitionDuration,
    transitionCurve: config.transitionCurve,
    builder: (context) => child,
  );
}
