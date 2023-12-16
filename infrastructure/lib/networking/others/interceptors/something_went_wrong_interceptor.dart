// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/dio.dart';

import '../exceptions/dio_exceptions.dart';

/// `SomethingWentWrongInterceptor` is a Dio interceptor for handling unexpected errors.
/// It extends the `Interceptor` class to catch any kind of `DioException` and handle it
/// by throwing a `SomethingWentWrongFailure`.
class SomethingWentWrongInterceptor extends Interceptor {
  /// Overrides the onError method to handle all Dio exceptions by throwing
  /// a `SomethingWentWrongFailure`.
  ///
  /// This method is used to catch any error that wasn't specifically handled
  /// by other interceptors and categorize it as a generic failure.
  ///
  /// [err]: The `DioException` encountered during the network request.
  /// [handler]: The `ErrorInterceptorHandler` for error handling.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Throw `SomethingWentWrongFailure` for any unhandled DioException.
    throw SomethingWentWrongFailure(exception: err);
  }
}
