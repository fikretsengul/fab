// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'cupertino_sheet_wrapper.dart';

Route<T> cupertinoSheetRouteBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
  if (page.child is! CupertinoSheetWrapperRoute) {
    throw ArgumentError('Child page must be of type CupertinoSheetWrapperRoute to use cupertinoSheetRouteBuilder.');
  }

  final cupertinoSheetWrapperRoute = page.child as CupertinoSheetWrapperRoute;
  final config = cupertinoSheetWrapperRoute.dialogConfig;

  return CupertinoModalPopupRoute<T>(
    settings: page,
    builder: (_) => child,
    filter: config.filter,
    barrierColor: CupertinoDynamicColor.resolve(config.barrierColor, context),
    barrierDismissible: config.barrierDismissible,
    semanticsDismissible: config.semanticsDismissible,
    anchorPoint: config.anchorPoint,
  );
}
