// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/locator/locator.dart';
import 'package:deps/packages/dio.dart';
import 'package:deps/packages/internet_connection_checker_plus.dart';

import '../exceptions/dio_exceptions.dart';

/// `NoNetworkInterceptor` is a Dio interceptor for handling network connectivity errors.
/// It extends Dio's `Interceptor` class to monitor and react to network connection issues.
class NoNetworkInterceptor extends Interceptor {
  /// Overrides the onError method to check for network connectivity issues.
  /// If an error occurs with no response and there's no internet access,
  /// it throws a `NoNetworkFailure`.
  ///
  /// [err]: The `DioException` encountered during the network request.
  /// [handler]: The `ErrorInterceptorHandler` for error handling.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check internet connectivity status.
    final connection = di<InternetConnection>();
    if (err.response == null && !await connection.hasInternetAccess) {
      // Throw `NoNetworkFailure` if no internet access is detected.
      throw NoNetworkFailure(exception: err);
    }

    // Pass control to the next interceptor in the chain for other errors.
    return handler.next(err);
  }

  /// Overrides the onRequest method to simply pass the request options along.
  ///
  /// [options]: The `RequestOptions` for the outgoing request.
  /// [handler]: The `RequestInterceptorHandler` for request handling.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Continue with the request processing.
    return handler.next(options);
  }
}
