import 'package:deps/packages/talker_flutter.dart' hide TalkerRouteLog;
import 'package:flutter/material.dart';

import '../../logger/talker/logs/route_log.dart';

/// Logging NavigatorObserver working on [Talker] base
/// This observer displays which routes were opened and closed in the application
class TalkerRouteObserver extends NavigatorObserver {
  TalkerRouteObserver({required this.talker});

  final Talker talker;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logTyped(RouteLog(route: route));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logTyped(RouteLog(route: route, isPush: false));
  }
}
