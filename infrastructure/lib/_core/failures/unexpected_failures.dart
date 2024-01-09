import '../../analytics/failure/failure.dart';
import '../enums/failure_tag_enum.dart';
import '../enums/failure_type_enum.dart';

class UnexpectedFailure extends Failure {
  UnexpectedFailure({super.exception})
      : super(
          code: 'unexpected-failure',
          type: FailureType.exception,
          tag: FailureTag.uncaught,
          message: 'An unexpected exception occurred.',
        );
}

class UnexpectedError extends Failure {
  UnexpectedError({super.exception, super.stack})
      : super(
          code: 'unexpected-error',
          type: FailureType.error,
          tag: FailureTag.uncaught,
          message: 'An unexpected error occurred.',
        );
}

class UnexpectedFlutterError extends Failure {
  UnexpectedFlutterError({super.exception, super.stack})
      : super(
          code: 'unexpected-flutter-error',
          type: FailureType.error,
          tag: FailureTag.uncaught,
          message: 'An unexpected flutter error occurred.',
        );
}

class UnexpectedPlatformError extends Failure {
  UnexpectedPlatformError({super.exception, super.stack})
      : super(
          code: 'unexpected-platform-error',
          type: FailureType.error,
          tag: FailureTag.uncaught,
          message: 'An unexpected platform error occurred.',
        );
}
