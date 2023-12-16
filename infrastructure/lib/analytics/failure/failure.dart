// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/locator/locator.dart';

import '../observers/failure_observer.dart';
import '../others/enums.dart';
import 'i_failure.dart';

/// `UnknownFailure` is a specific type of `Failure` representing an unclassified,
/// or unknown error. It extends from `Failure` and provides default values
/// indicating an unknown failure scenario.
class UnknownFailure extends Failure {
  /// Constructs an `UnknownFailure` with optional [exception] and [stack].
  /// Assigns predefined values to represent an unknown failure.
  UnknownFailure({
    super.exception,
    super.stack,
  }) : super(
          code: 'unknown-failure',
          type: FailureType.exception,
          tag: FailureTag.uncaught,
          message: 'tr.exceptions.unknownFailure',
        );
}

/// `Failure` class implementing the `IFailure` interface.
/// Represents a standardized failure or error within the application.
class Failure implements IFailure {
  /// Constructs a `Failure` with necessary details.
  /// Automatically notifies the `FailureObserver` upon creation.
  ///
  /// [type]: The type of failure.
  /// [tag]: A tag providing additional context for the failure.
  /// [code]: A unique code identifying this failure.
  /// [message]: A human-readable message describing the failure.
  /// [exception]: The underlying exception, if any.
  /// [stack]: The associated stack trace, if available.
  Failure({
    required this.type,
    required this.tag,
    required this.code,
    required this.message,
    this.exception,
    this.stack,
  }) {
    di<FailureObserver>().onFailure(this);
  }

  factory Failure.slient() => Failure(type: FailureType.slient, tag: FailureTag.uncaught, code: '', message: '');

  @override
  final String code;

  @override
  final Exception? exception;

  @override
  final String message;

  @override
  final StackTrace? stack;

  @override
  final FailureTag tag;

  @override
  final FailureType type;

  bool get isSlient => type == FailureType.slient;
}
