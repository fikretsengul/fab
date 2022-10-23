import 'package:dio/dio.dart';
import 'package:flutter_advanced_boilerplate/modules/dio/dio_exception_handler.dart';

class InternalServerErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      if (err.response!.statusCode != null && err.response!.statusCode! >= 500 && err.response!.statusCode! < 600) {
        return handler.reject(
          InternalServerException(
            requestOptions: err.requestOptions,
          ),
        );
      }
    }

    return handler.next(err);
  }
}
