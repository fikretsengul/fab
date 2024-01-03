import '../../_core/enums/failure_tag_enum.dart';
import '../../_core/i18n/translations.g.dart';
import '../../analytics/failure/failure.dart';

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
