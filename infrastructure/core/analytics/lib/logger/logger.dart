// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_flutter.dart';

import 'i_logger.dart';

/// `Logger` class implementing `ILogger` interface.
/// Uses `Talker` for different types of logging functionalities.
/// Registered as a lazy singleton for dependency injection.
@lazySingleton
class Logger implements ILogger {
  /// Constructs `Logger` with an instance of `Talker`.
  Logger(this._talker);

  final Talker _talker;

  /// Logs a constructive action or event message.
  /// Uses `Talker`'s `good` method for positive notifications.
  /// [message]: The message to be logged.
  @override
  void constructive(String message) {
    _talker.good(message);
  }

  /// Logs a destructive action or event message.
  /// Uses `Talker`'s `warning` method for cautionary notifications.
  /// [message]: The message to be logged.
  @override
  void destructive(String message) {
    _talker.warning(message);
  }

  /// Logs exceptions with an optional [exception] object and [stackTrace].
  /// Uses `Talker`'s `critical` method for logging severe issues.
  /// [message]: A message describing the exception.
  /// [exception]: The exception object, if available.
  /// [stackTrace]: The stack trace associated with the exception, if available.
  @override
  void exception(
    String message, {
    Exception? exception,
    StackTrace? stackTrace,
  }) {
    _talker.critical(
      message,
      exception,
      stackTrace,
    );
  }

  /// Logs general messages with optional [data].
  /// Uses `Talker`'s `debug` method for detailed debugging information.
  /// [message]: The primary log message.
  /// [data]: Optional additional data to include in the log.
  @override
  void log(
    String message, {
    dynamic data,
  }) {
    _talker.debug(
      "\n• MESSAGE\t› $message${data != null ? '\n• DATA\t› $data' : ''}",
    );
  }
}
