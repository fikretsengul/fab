import 'package:deps/packages/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../application.dart';
import '../../../page.dart';
import '../../page/page_type.dart';

/// A method to consolidate page creation based on the PageType.
Page<dynamic> createPageBasedOnType(
  BuildContext context,
  GoRouterState state,
  Widget childWidget,
  PageType type,
) {
  // PageScope creation to wrap around the child widget.
  final pageScope = PageScope(
    cache: context.app.cache,
    name: state.matchedLocation,
    path: state.uri.toString(),
    pathParams: state.pathParameters,
    queryParams: state.uri.queryParameters,
    logger: context.app.logger,
    child: childWidget,
  );

  // Set the page in analytics
  context.app.analytics.setPage(
    state.matchedLocation,
    childWidget.runtimeType.toString(),
  );

  // Return the appropriate page based on the type
  switch (type) {
    case PageType.auto:
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
        return CupertinoPage(child: pageScope);
      }
      return MaterialPage(child: pageScope);
    case PageType.material:
      return MaterialPage(child: pageScope);
    case PageType.cupertino:
      return CupertinoPage(child: pageScope);
    case PageType.noTransition:
      return NoTransitionPage(child: pageScope);
  }
}
