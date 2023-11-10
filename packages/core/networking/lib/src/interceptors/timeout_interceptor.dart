import 'package:deps/dio.dart';

import '../exceptions/dio_exceptions.dart';

class TimeoutInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      throw TimeoutFailure(exception: err);
    }

    return handler.next(err);
  }
}
