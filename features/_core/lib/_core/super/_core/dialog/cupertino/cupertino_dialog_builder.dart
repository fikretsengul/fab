// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'cupertino_dialog_wrapper.dart';

Route<T> cupertinoDialogRouteBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
  if (page.child is! CupertinoDialogWrapperRoute) {
    throw ArgumentError('Child page must be of type CupertinoDialogWrapperRoute to use cupertinoDialogRouteBuilder.');
  }

  final cupertinoDialogWrapperRoute = page.child as CupertinoDialogWrapperRoute;
  final config = cupertinoDialogWrapperRoute.dialogConfig;

  return CupertinoDialogRoute<T>(
    settings: page,
    builder: (_) => child,
    context: context,
    barrierColor: config.barrierColor,
    barrierLabel: config.barrierLabel,
    barrierDismissible: config.barrierDismissible,
    transitionDuration: config.transitionDuration,
    transitionBuilder: config.transitionBuilder,
    anchorPoint: config.anchorPoint,
  );
}
