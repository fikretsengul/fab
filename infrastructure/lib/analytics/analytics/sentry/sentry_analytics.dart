// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/sentry_flutter.dart';

import '../i_analytics.dart';

/// [Analytics] class implementing [IAnalytics] interface.
/// Uses Sentry for capturing events and user information.
/// Registered as a singleton in the dependency injection system.
@Singleton(as: IAnalytics)
class SentryAnalytics implements IAnalytics {
  SentryAnalytics();

  /// Sends a custom [message] to Sentry as an event.
  /// [message]: The message or event string to be logged.
  @override
  void send(String message) {
    Sentry.captureEvent(
      SentryEvent(
        message: SentryMessage(message),
      ),
    );
  }

  /// Configures Sentry's scope for the current page view.
  /// Sets extra information about the screen being viewed.
  /// [name]: Name of the page, [widgetName]: Name of the widget.
  @override
  void setPage(String name, String widgetName) {
    Sentry.configureScope((scope) {
      scope
        ..setExtra('screenName', name)
        ..setExtra('screenClassOverride', widgetName);
    });
  }

  /// Sets or updates the user ID in Sentry's scope.
  /// [id]: User's unique identifier or `null` to remove the user.
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
