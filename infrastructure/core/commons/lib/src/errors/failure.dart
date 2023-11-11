import 'package:deps/core/analytics/observer.dart';
import 'package:deps/locator/locator.dart';

import '../enums/failure_enums.dart';
import 'i_failure.dart';

class UnknownFailure extends Failure {
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

class Failure implements IFailure {
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
}
