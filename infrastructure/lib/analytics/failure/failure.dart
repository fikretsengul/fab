// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/locator/locator.dart';

import '../../_core/enums/failure_tag_enum.dart';
import '../../_core/enums/failure_type_enum.dart';
import '../observers/i_failure_observer.dart';
import 'i_failure.dart';

/// `Failure` class implementing the `IFailure` interface.
/// Represents a standardized failure or error within the application.
class Failure implements IFailure {
  Failure({
    required this.type,
    required this.tag,
    required this.code,
    required this.message,
    dynamic exception,
    this.stack,
  })  : _failureObserver = locator<IFailureObserver>(),
        exception = (type == FailureType.exception || type == FailureType.error)
            ? (exception ??
                (throw ArgumentError('Exception must be provided for FailureType.exception or FailureType.error')))
            : exception {
    _failureObserver.onFailure(this);
  }

  factory Failure.empty() => Failure(
        type: FailureType.empty,
        tag: FailureTag.empty,
        code: '',
        message: '',
      );

  final IFailureObserver _failureObserver;

  @override
  final String code;

  @override
  final dynamic exception;

  @override
  final String message;

  @override
  final StackTrace? stack;

  @override
  final FailureTag tag;

  @override
  final FailureType type;

  bool get isEmpty => type == FailureType.empty;
}
