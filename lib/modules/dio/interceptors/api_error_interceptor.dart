import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_advanced_boilerplate/modules/dio/dio_exception_handler.dart';

class ApiErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response!.statusCode != null &&
        (err.response!.statusCode! == 400 || err.response!.statusCode! == 404)) {
      try {
        final message = json.decode(err.response.toString()) as Map<String, dynamic>;
        final errors = json.decode(message['detail'] as String) as List<String>;
        final error = errors.first;

        return handler.reject(
          ApiException(
            errorMessage: error,
            requestOptions: err.requestOptions,
            response: err.response,
            error: err.error,
            type: err.type,
          ),
        );
      } catch (e) {
        final result = jsonDecode(err.response?.data.toString() ?? '') as Map<String, dynamic>;

        return result['title'] == 'One or more validation errors occurred.'
            ? handler.reject(InvalidJsonFormatException(requestOptions: err.requestOptions))
            : handler.reject(InternalServerException(requestOptions: err.requestOptions));
      }
    }

    return handler.next(err);
  }
}
