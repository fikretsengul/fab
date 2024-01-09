import 'dart:async';

/// Extension on `Duration` to provide a simple delay mechanism.
extension TimingsExt on Duration {
  /// Delays the execution of a callback function by the duration.
  /// If no callback is provided, it simply waits for the duration.
  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        this,
        callback,
      );
}
