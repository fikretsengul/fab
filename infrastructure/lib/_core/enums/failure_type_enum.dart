// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

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
