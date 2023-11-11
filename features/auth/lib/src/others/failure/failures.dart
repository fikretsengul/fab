import 'package:deps/core/commons/enums.dart';
import 'package:deps/core/commons/errors.dart';

class WrongCredentialsFailure extends Failure {
  WrongCredentialsFailure()
      : super(
          code: 'wrong-credentials-failure',
          type: FailureType.destructive,
          tag: FailureTag.repository,
          message: 'tr.exceptions.auth.wrongCredentialsFailure',
        );
}
