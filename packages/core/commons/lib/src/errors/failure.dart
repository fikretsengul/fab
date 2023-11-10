import 'package:analytics/observer.dart';
import 'package:locator/locator.dart';

import '../enums/failure_enums.dart';
import 'i_failure.dart';

class UnknownFailure extends Failure {
  UnknownFailure({
    super.exception,
    super.stack,
  }) : super(
          code: 'wrong-credentials-failure',
          type: FailureType.exception,
          tag: FailureTag.uncaught,
          message: 'tr.exceptions.wrongCredentialsFailure',
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
