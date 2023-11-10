import 'offline_analytics.dart';

abstract class IAnalytics {
  factory IAnalytics.offline() {
    return OfflineAnalytics();
  }

  /// Setting [id] to null will remove the user from analytics.
  void setUserId(String? id);

  /// Inform analytics what page the user is currently viewing.
  void setPage(String name, String widgetName);

  /// Send to analytics.
  void send(String message);
}
