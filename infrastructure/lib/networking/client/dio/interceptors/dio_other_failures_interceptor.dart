import 'package:deps/locator/locator.dart';
import 'package:deps/packages/dio.dart';
import 'package:deps/packages/internet_connection_checker_plus.dart';

import '../../../../analytics/failure/i_failure.dart';
import '../../../others/failures/network_errors.dart';
import '../../../others/failures/network_failures.dart';
import '../dio_failure.dart';

class DioOtherFailuresInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final connection = di<InternetConnection>();
    late IFailure failure;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        failure = ConnectionTimeoutNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.sendTimeout:
        failure = SendTimeoutNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.receiveTimeout:
        failure = ReceiveTimeoutNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.badCertificate:
        failure = BadCertificateNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.badResponse:
        failure = BadResponseNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.cancel:
        failure = RequestCancelNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.connectionError:
        failure = ConnectionNetworkFailure(exception: err, stack: err.stackTrace);
      case DioExceptionType.unknown:
      default:
        if (err.response == null && !await connection.hasInternetAccess) {
          failure = NoNetworkFailure(exception: err);
        }

        failure = UnexpectedNetworkError(exception: err, stack: err.stackTrace);
    }

    return handler.reject(
      DioFailure(
        failure: failure,
        requestOptions: err.requestOptions,
      ),
    );
  }
}
