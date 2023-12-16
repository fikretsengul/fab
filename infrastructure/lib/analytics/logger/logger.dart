// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_flutter.dart';

import 'i_logger.dart';

/// Implementation of the [ILogger] interface using the Talker package.
///
/// This class provides mechanisms for logging different types of messages,
/// including general logs, constructive messages, destructive messages, and exceptions.
@lazySingleton
class Logger implements ILogger {
  /// Constructor for [Logger] that takes [Talker] as a dependency.
  Logger(this._talker);

  final Talker _talker;

  /// Logs a constructive message using the Talker package.
  @override
  void constructive(String message) {
    _talker.good(message);
  }

  /// Logs a destructive message, typically used for warnings or errors.
  @override
  void destructive(String message) {
    _talker.warning(message);
  }

  /// Logs an exception with an optional stack trace.
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

  /// Logs general data with an optional message.
  /// Formats the log output to include either the message or the data type and the data itself.
  @override
  void log(
    dynamic data, {
    String? message,
  }) {
    final hasMessage = message != null;
    final text = hasMessage ? 'MESSAGE' : 'TYPE';
    final value = hasMessage ? message : data.runtimeType;

    _talker.debug(
      "\n• $text\t› $value${data != null ? '\n• DATA\t› $data' : ''}",
    );
  }
}
