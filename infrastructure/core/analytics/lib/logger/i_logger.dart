// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// `ILogger` is an abstract interface defining a logging contract.
/// This interface provides methods to log different types of messages
/// and events within an application.
abstract interface class ILogger {
  /// Logs a general message with optional additional [data].
  ///
  /// Use this method for general-purpose logging of information.
  /// [message]: The primary log message.
  /// [data]: Optional additional data to include in the log.
  void log(
    dynamic data, {
    String? message,
  });

  /// Logs a message related to constructive actions or events.
  ///
  /// Use this for logging actions that positively affect the application's state.
  /// [message]: The message describing the constructive action.
  void constructive(String message);

  /// Logs a message related to destructive actions or events.
  ///
  /// Use this for logging actions that negatively impact or dismantle state.
  /// [message]: The message describing the destructive action.
  void destructive(String message);

  /// Logs exceptions along with an optional [exception] object and [stackTrace].
  ///
  /// Use this method for detailed logging of exceptions and errors.
  /// [message]: A message describing the exception.
  /// [exception]: The exception object, if available.
  /// [stackTrace]: The stack trace associated with the exception, if available.
  void exception(
    String message, {
    Exception? exception,
    StackTrace? stackTrace,
  });
}
