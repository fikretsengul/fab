// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'dart:io';

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/dio_smart_retry.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter/foundation.dart';

import '../../../_core/enums/request_type_enum.dart';
import '../../../_core/failures/unexpected_failures.dart';
import '../../../_core/typedefs/either_typedef.dart';
import '../../../analytics/logger/i_logger.dart';
import '../../../flavors/i_env.dart';
import '../../../storage/storages/token/token_storage_mixin.dart';
import '../../models/o_auth2_token.model.dart';
import '../i_network_client.dart';
import 'dio_failure.dart';
import 'dio_token_refresh.dart';
import 'interceptors/dio_http_failures_interceptor.dart';
import 'interceptors/dio_other_failures_interceptor.dart';

/// `DioClient` implements the `INetworkClient` interface, offering a Dio-based
/// HTTP client setup. It integrates various interceptors for error handling,
/// automatic token refresh, and retry mechanisms.
///
/// This client is configured based on the environment settings and is suitable
/// for making network requests with necessary error handling and logging.
@LazySingleton(as: INetworkClient)
class DioClient implements INetworkClient {
  /// Constructs `DioClient` with environment, logger, Dio instance, and storage dependencies.
  /// Sets up Dio with base URL, headers, connection timeouts, and interceptors.
  DioClient(
    this._env,
    this._logger,
    this._dio,
    this._tokenRefresh,
  ) {
    _dio
      // Configuration for Dio.
      ..options.baseUrl = _env.apiUrl
      ..options.headers['Accept-Language'] = kIsWeb ? 'en-US' : Platform.localeName.substring(0, 2)
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      // Adding various interceptors.
      ..interceptors.add(_tokenRefresh.interceptor)
      ..interceptors.add(DioHttpFailuresInterceptor())
      ..interceptors.add(DioOtherFailuresInterceptor())
      // Retry interceptor for network retries.
      ..interceptors.add(
        RetryInterceptor(
          dio: _dio,
          logPrint: _logger.debug,
          retries: 2,
        ),
      );
  }

  final Dio _dio;
  final IEnv _env;
  final ILogger _logger;
  final DioTokenRefresh _tokenRefresh;

  @override
  TokenStorageMixin<OAuth2Token> get tokenStorage => _tokenRefresh.interceptor;

  /// Overrides `invoke` from `INetworkClient` to handle various types of HTTP requests.
  /// Implements error handling and mapping Dio responses to Either types.
  ///
  /// [url]: The URL endpoint for the request.
  /// [requestType]: The HTTP method (GET, POST, PUT, DELETE, PATCH).
  /// [queryParameters]: Optional query parameters.
  /// [headers]: Optional headers for the request.
  /// [requestBody]: Optional body for the request.
  ///
  /// Returns an `AsyncEither` with either a `Failure` or the response data.
  @override
  AsyncEither<R> invoke<T, R>(
    String path,
    RequestType requestType, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    dynamic requestBody,
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    Response<dynamic> response;

    // Assert to ensure fromJson is provided when R is a list and fromJson is needed.
    assert(
      !(R is List<dynamic> && fromJson == null),
      'fromJson must be provided when R is a list.',
    );

    try {
      // Handling different request types.
      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.post:
          response = await _dio.post(
            path,
            queryParameters: queryParameters,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.put:
          response = await _dio.put(
            path,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.delete:
          response = await _dio.delete(
            path,
            queryParameters: queryParameters,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.patch:
          response = await _dio.patch(
            path,
            queryParameters: queryParameters,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
      }

      if (fromJson != null) {
        if (response.data is List) {
          final list = (response.data as List).map((item) => fromJson(item as Map<String, dynamic>)).toList();

          return Right(list as R);
        } else {
          return Right(fromJson(response.data as Map<String, dynamic>) as R);
        }
      } else {
        return Right(response.data as R);
      }
    } on DioFailure catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(UnexpectedError(exception: e));
    }
  }

  @override
  void setObserver(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
