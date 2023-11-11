import 'package:deps/core/commons/enums.dart';
import 'package:deps/core/commons/errors.dart';

class NoNetworkFailure extends Failure {
  NoNetworkFailure({super.exception})
      : super(
          code: 'no-network-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.noNetworkFailure',
        );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({super.exception})
      : super(
          code: 'timeout-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.timeoutFailure',
        );
}

class SomethingWentWrongFailure extends Failure {
  SomethingWentWrongFailure({super.exception})
      : super(
          code: 'something-went-wrong-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.somethingWentWrong',
        );
}

class InternalServerFailure extends Failure {
  InternalServerFailure({super.exception})
      : super(
          code: 'internal-server-failure',
          type: FailureType.exception,
          tag: FailureTag.dio,
          message: 'tr.exceptions.internalServerFailure',
        );
}
