import '../../../analytics/failure/failure.dart';
import '../../../analytics/others/enums.dart';
import '../../../core/i18n/translations.g.dart';

class UnexpectedNetworkError extends Failure {
  UnexpectedNetworkError({super.exception, super.stack})
      : super(
          code: 'unexpected-network-error',
          type: FailureType.error,
          tag: FailureTag.network,
          message: tr.failures.network.unexpected,
        );
}

class UnexpectedTokenRefreshNetworkError extends Failure {
  UnexpectedTokenRefreshNetworkError({super.exception, super.stack})
      : super(
          code: 'unexpected-token-refresh-network-error',
          type: FailureType.error,
          tag: FailureTag.network,
          message: tr.failures.network.unexpectedTokenRefresh,
        );
}
