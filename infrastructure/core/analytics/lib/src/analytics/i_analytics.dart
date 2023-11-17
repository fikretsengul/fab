// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// `IAnalytics` interface for analytics handling
/// Provides methods to track user ID, page views, and send custom messages.
abstract interface class IAnalytics {
  /// Sets or removes the user ID for analytics.
  /// Passing `null` as [id] will disassociate the current user.
  /// [id]: User's unique identifier or `null`.
  void setUserId(String? id);

  /// Logs the current page the user is viewing for analytics.
  /// [name]: Name of the page, [widgetName]: Name of the widget.
  void setPage(String name, String widgetName);

  /// Sends a custom message to the analytics service.
  /// [message]: The message or event to log.
  void send(String message);
}
