// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/dio.dart';

import '../exceptions/dio_exceptions.dart';

/// `InternalServerInterceptor` is a Dio interceptor specifically for handling internal server errors.
/// It extends the Dio `Interceptor` class to intercept error responses from the network.
class InternalServerInterceptor extends Interceptor {
  /// Overrides the onError method to handle errors.
  /// Specifically, it checks for internal server errors (status codes 500-599)
  /// and throws an `InternalServerFailure` when such an error is encountered.
  ///
  /// [err]: The `DioException` encountered during the network request.
  /// [handler]: The `ErrorInterceptorHandler` to pass control to the next interceptor in the chain.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if the error response is not null and if the status code indicates an internal server error.
    if (err.response != null) {
      final statusCode = err.response!.statusCode;

      // If it's an internal server error, throw `InternalServerFailure`.
      if (statusCode != null && statusCode >= 500 && statusCode < 600) {
        throw InternalServerFailure(exception: err);
      }
    }

    // Pass control to the next interceptor in the chain.
    return handler.next(err);
  }
}
