import '../../others/enums.dart';
import '../failure.dart';

class UnexpectedError extends Failure {
  UnexpectedError({super.exception, super.stack})
      : super(
          code: 'unexpected-error',
          type: FailureType.error,
          tag: FailureTag.uncaught,
          message: 'An unexpected error occurred.',
        );
}
