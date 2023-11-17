// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/core/analytics/analytics.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'enums.dart';

/// Creates a page based on the specified `PageType`.
/// This method centralizes the logic for deciding what type of page to create
/// (Material, Cupertino, etc.) based on the application's needs and the platform.
///
/// [context]: The build context.
/// [state]: The current state of GoRouter.
/// [child]: The child widget to be included in the page.
/// [type]: The `PageType` that determines what kind of page to create.
///
/// Returns a `Page<dynamic>` object that corresponds to the specified type.
Page<dynamic> createPageBasedOnType(
  BuildContext context,
  GoRouterState state,
  Widget child,
  PageType type,
) {
  // Tracks the page view in analytics.
  di<Analytics>().setPage(
    state.matchedLocation,
    child.runtimeType.toString(),
  );

  // Selects the appropriate page type based on the given `PageType`.
  switch (type) {
    case PageType.auto:
      // Auto-selects Cupertino or Material page based on the platform.
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
        return CupertinoPage(child: child);
      }
      return MaterialPage(child: child);
    case PageType.material:
      // Explicitly uses a MaterialPage.
      return MaterialPage(child: child);
    case PageType.cupertino:
      // Explicitly uses a CupertinoPage.
      return CupertinoPage(child: child);
    case PageType.noTransition:
      // Uses a page with no transition animations.
      return NoTransitionPage(child: child);
  }
}
