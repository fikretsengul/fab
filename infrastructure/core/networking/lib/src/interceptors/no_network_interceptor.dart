import 'package:deps/locator/locator.dart';
import 'package:deps/packages/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../exceptions/dio_exceptions.dart';

class NoNetworkInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final connection = di<InternetConnection>();
    if (err.response == null && !await connection.hasInternetAccess) {
      throw NoNetworkFailure(exception: err);
    }

    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }
}
