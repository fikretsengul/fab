import 'package:deps/packages/dio.dart';

import '../../../../analytics/failure/i_failure.dart';
import '../../../others/failures/network_failures.dart';
import '../dio_failure.dart';

class DioHttpFailuresInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response != null && err.response!.statusCode != null) {
      final statusCode = err.response!.statusCode!;
      late IFailure failure;

      switch (statusCode) {
        case 200:
        case 201:
        case 204:
          // Success responses (OK, Created, No Content), no action is needed.
          break;

        case 400:
          failure = BadRequestNetworkFailure(exception: err, stack: err.stackTrace);

        case 401:
          failure = UnauthorizedNetworkFailure(exception: err, stack: err.stackTrace);

        case 403:
          failure = ForbiddenNetworkFailure(exception: err, stack: err.stackTrace);

        case 404:
          failure = NotFoundNetworkFailure(exception: err, stack: err.stackTrace);

        case 408:
          failure = RequestTimeoutNetworkFailure(exception: err, stack: err.stackTrace);

        case 429:
          failure = TooManyRequestsNetworkFailure(exception: err, stack: err.stackTrace);

        case 500:
          failure = InternalServerNetworkFailure(exception: err, stack: err.stackTrace);

        default:
          if (statusCode > 500) {
            failure = ServerErrorNetworkFailure(exception: err, stack: err.stackTrace);
          } else if (statusCode > 400) {
            failure = ClientErrorNetworkFailure(exception: err, stack: err.stackTrace);
          }
      }

      return handler.reject(
        DioFailure(
          failure: failure,
          requestOptions: err.requestOptions,
        ),
      );
    }

    // For any status code not explicitly handled, just pass the response along.
    return handler.next(err);
  }
}
