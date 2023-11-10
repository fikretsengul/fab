import 'package:deps/dio.dart';

import '../exceptions/dio_exceptions.dart';

class InternalServerInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response != null) {
      final statusCode = err.response!.statusCode;

      if (statusCode != null && statusCode >= 500 && statusCode < 600) {
        throw InternalServerFailure(exception: err);
      }
    }

    return handler.next(err);
  }
}
