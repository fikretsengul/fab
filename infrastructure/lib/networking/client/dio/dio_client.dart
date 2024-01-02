// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'dart:io';

import 'package:deps/locator/locator.dart';
import 'package:deps/packages/dio.dart';
import 'package:deps/packages/dio_smart_retry.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/foundation.dart';

import '../../../_core/enums/request_type_enum.dart';
import '../../../analytics/logger/i_logger.dart';
import '../../../analytics/others/typedefs.dart';
import '../../../flavors/i_env.dart';
import '../../../storage/storages/token/token_storage_mixin.dart';
import '../../models/o_auth2_token.model.dart';
import '../../others/failures/network_errors.dart';
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
          logPrint: _logger.log,
          retries: 2,
        ),
      );

    // Additional logging interceptor for debug mode.
    if (_env.isDebug) {
      _dio.interceptors.add(
        TalkerDioLogger(
          talker: di<Talker>(),
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }
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
  AsyncEither<T> invoke<T>(
    String path,
    RequestType requestType, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    dynamic requestBody,
  }) async {
    Response<dynamic> response;

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

      return Right(response.data as T);
    } on DioFailure catch (e) {
      return Left(e.failure);
    } catch (e) {
      if (e is Exception) {
        return Left(UnexpectedNetworkError(exception: e));
      } else {
        return Left(UnexpectedNetworkError(exception: Exception(e.toString())));
      }
    }
  }
}
