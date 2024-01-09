// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Defines different types of log levels.
enum LogType {
  /// Detailed logging information, typically for development purposes.
  verbose,

  /// General informational messages.
  info,

  /// Debug level messages, useful during development.
  debug,

  /// Indicates a warning situation.
  warning,

  /// Represents an error condition.
  error,
}
