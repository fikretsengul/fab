import 'package:commons/enums.dart';
import 'package:commons/errors.dart';

class WrongCredentialsFailure extends Failure {
  WrongCredentialsFailure()
      : super(
          code: 'wrong-credentials-failure',
          type: FailureType.destructive,
          tag: FailureTag.repository,
          message: 'tr.exceptions.auth.wrongCredentialsFailure',
        );
}
