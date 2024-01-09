import '../../_core/enums/failure_tag_enum.dart';
import '../../_core/enums/failure_type_enum.dart';
import '../../analytics/failure/failure.dart';

class UnexpectedNetworkError extends Failure {
  UnexpectedNetworkError({super.exception, super.stack})
      : super(
          code: 'unexpected-network-error',
          type: FailureType.error,
          tag: FailureTag.network,
          message: 'An unexpected network error occurred. Please check your connection and try again.',
        );
}

class UnexpectedTokenRefreshNetworkError extends Failure {
  UnexpectedTokenRefreshNetworkError({super.exception, super.stack})
      : super(
          code: 'unexpected-token-refresh-network-error',
          type: FailureType.error,
          tag: FailureTag.network,
          message:
              'An unexpected error occurred while refreshing the authentication token. Please re-authenticate and try again.',
        );
}
