// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../../../analytics/failure/failure.dart';
import '../../../analytics/others/enums.dart';

/// `NoNetworkFailure` represents a failure due to network unavailability.
/// Extends from the `Failure` class, providing specific details for this type of error.
class NoNetworkFailure extends Failure {
  /// Constructs a `NoNetworkFailure` with an optional exception.
  /// Sets predefined values indicating a network-related failure.
  NoNetworkFailure({super.exception})
      : super(
          code: 'no-network-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.noNetworkFailure',
        );
}

/// `TimeoutFailure` represents a failure due to a timeout event, typically in network requests.
/// Extends from the `Failure` class with details specific to timeout errors.
class TimeoutFailure extends Failure {
  /// Constructs a `TimeoutFailure` with an optional exception.
  /// Sets predefined values indicating a timeout-related failure.
  TimeoutFailure({super.exception})
      : super(
          code: 'timeout-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.timeoutFailure',
        );
}

/// `SomethingWentWrongFailure` represents a general failure when something unexpected occurs.
/// Extends from the `Failure` class with a generic error message.
class SomethingWentWrongFailure extends Failure {
  /// Constructs a `SomethingWentWrongFailure` with an optional exception.
  /// Sets predefined values for a generic error.
  SomethingWentWrongFailure({super.exception})
      : super(
          code: 'something-went-wrong-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.somethingWentWrong',
        );
}

/// `InternalServerFailure` represents a failure due to internal server errors.
/// Extends from the `Failure` class, indicating an error on the server side.
class InternalServerFailure extends Failure {
  /// Constructs an `InternalServerFailure` with an optional exception.
  /// Sets predefined values for server-related failures.
  InternalServerFailure({super.exception})
      : super(
          code: 'internal-server-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.internalServerFailure',
        );
}
