// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/dio.dart';

import '../exceptions/dio_exceptions.dart';

/// `TimeoutInterceptor` is a Dio interceptor for handling timeout-related exceptions.
/// It extends Dio's `Interceptor` class to catch and handle exceptions due to timeouts
/// during network requests.
class TimeoutInterceptor extends Interceptor {
  /// Overrides the onError method to handle timeout exceptions.
  ///
  /// This method checks if the encountered Dio exception is related to
  /// connection, send, or receive timeouts. If so, it throws a `TimeoutFailure`.
  ///
  /// [err]: The `DioException` encountered during the network request.
  /// [handler]: The `ErrorInterceptorHandler` for error handling.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if the error is one of the timeout types.
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      // Throw `TimeoutFailure` for timeout-related errors.
      throw TimeoutFailure(exception: err);
    }

    // Pass control to the next interceptor in the chain for other errors.
    return handler.next(err);
  }
}
