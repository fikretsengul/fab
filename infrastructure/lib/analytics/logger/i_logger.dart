// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../failure/i_failure.dart';

/// An abstract class defining the interface for a logging system.
///
/// Implementations of [ILogger] should provide mechanisms for various
/// logging levels and types, such as general logs, constructive logs,
/// destructive logs, and exceptions.
abstract class ILogger {
  /// Logs general data with an optional message.
  ///
  /// [data]: The data to be logged.
  /// [message]: An optional message to accompany the data.
  void debug(
    dynamic data, [
    String? message,
  ]);

  /// Logs an exception with an optional stack trace.
  ///
  /// [message]: The message describing the exception.
  /// [exception]: The exception to be logged.
  /// [stackTrace]: The stack trace associated with the exception.
  void exception(IFailure failure);

  void error(IFailure failure);
}
