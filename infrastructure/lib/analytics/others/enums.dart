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

/// Defines different types of failures.
enum FailureType {
  /// Indicates a constructive failure, used in app for snack-bar purposes.
  constructive,

  /// Indicates a destructive failure, used in app for snack-bar purposes.
  destructive,

  /// Represents an exception, typically used for unexpected errors.
  exception,

  /// Represents a critical failure or critical issues.
  error,

  /// Indicates empty failure type.
  empty,
}

/// Enumerates various tags used to categorize failures.
enum FailureTag {
  /// Failure in a Cubit (BLoC pattern component).
  state,

  /// Failure related to network requests.
  network,

  /// Failure encountered in a repository layer.
  repository,

  /// Failure related to page or UI components.
  page,

  /// Uncaught or unexpected failure.
  uncaught,

  /// Indicates empty failure tag.
  empty,
}
