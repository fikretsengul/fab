import 'package:deps/packages/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'i_analytics.dart';

@lazySingleton
class Analytics implements IAnalytics {
  Analytics();

  @override
  void send(String message) {
    Sentry.captureEvent(
      SentryEvent(
        message: SentryMessage(message),
      ),
    );
  }

  @override
  void setPage(String name, String widgetName) {
    Sentry.configureScope((scope) {
      scope
        ..setExtra('screenName', name)
        ..setExtra('screenClassOverride', widgetName);
    });
  }

  @override
  void setUserId(String? id) {
    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(
          id: id,
        ),
      );
    });
  }
}
