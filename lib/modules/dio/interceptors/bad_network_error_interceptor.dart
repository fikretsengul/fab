import 'package:dio/dio.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/modules/dio/dio_exception_handler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class BadNetworkErrorInterceptor extends Interceptor {
  final InternetConnectionChecker _networkInfo = getIt<InternetConnectionChecker>();

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response == null && !await _networkInfo.hasConnection) {
      return handler.reject(
        BadNetworkException(
          requestOptions: err.requestOptions,
        ),
      );
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
