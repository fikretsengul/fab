import 'package:deps/dio.dart';

import '../exceptions/dio_exceptions.dart';

class SomethingWentWrongInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    throw SomethingWentWrongFailure(exception: err);
  }
}
