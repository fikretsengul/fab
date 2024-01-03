// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../../_core/enums/failure_tag_enum.dart';

/// `IFailure` abstract interface class representing a standardized failure or error.
/// Implements [Exception] and provides detailed information about the failure.
///
/// This interface standardizes error handling across the application, allowing
/// for consistent logging, debugging, and error management. The properties
/// provide detailed context about the nature and specifics of the failure.
abstract interface class IFailure implements Exception {
  /// The type of the failure, indicating the general category.
  FailureType get type;

  /// A tag providing additional context or classification for the failure.
  FailureTag get tag;

  /// A code uniquely identifying this specific failure instance.
  String get code;

  /// A human-readable message describing the failure.
  String get message;

  /// The underlying [Exception] if available, providing further details.
  Exception? get exception;

  /// The [StackTrace] associated with the failure, if available.
  StackTrace? get stack;
}
