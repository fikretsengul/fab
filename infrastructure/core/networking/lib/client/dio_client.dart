// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file
// ignore_for_file: max_lines_for_function

import 'dart:io';

import 'package:deps/core/analytics/common.dart';
import 'package:deps/core/analytics/failure.dart';
import 'package:deps/core/analytics/logger.dart';
import 'package:deps/core/flavors/flavors.dart';
import 'package:deps/core/storage/storages.dart';
import 'package:deps/packages/dio.dart';
import 'package:deps/packages/dio_smart_retry.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:flutter/foundation.dart';

import '../models/o_auth2_token.model.dart';
import '../others/exceptions/dio_exceptions.dart';
import '../others/interceptors/internal_server_interceptor.dart';
import '../others/interceptors/no_network_interceptor.dart';
import '../others/interceptors/something_went_wrong_interceptor.dart';
import '../others/interceptors/timeout_interceptor.dart';
import 'dio_token_refresh.dart';
import 'i_network_client.dart';

/// `DioClient` implements the `INetworkClient` interface, offering a Dio-based
/// HTTP client setup. It integrates various interceptors for error handling,
/// automatic token refresh, and retry mechanisms.
///
/// This client is configured based on the environment settings and is suitable
/// for making network requests with necessary error handling and logging.
@lazySingleton
class DioClient implements INetworkClient {
  /// Constructs `DioClient` with environment, logger, Dio instance, and storage dependencies.
  /// Sets up Dio with base URL, headers, connection timeouts, and interceptors.
  DioClient(this._env, this._logger, this._dio, this._storage) {
    _dio
      // Configuration for Dio.
      ..options.baseUrl = _env.apiUrl
      ..options.headers['Accept-Language'] = kIsWeb ? 'en-US' : Platform.localeName.substring(0, 2)
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      // Adding various interceptors.
      ..interceptors.add(NoNetworkInterceptor())
      ..interceptors.add(TimeoutInterceptor())
      ..interceptors.add(SomethingWentWrongInterceptor())
      ..interceptors.add(InternalServerInterceptor())
      ..interceptors.add(DioTokenRefresh(_storage).interceptor)
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
  final Logger _logger;
  final IStorage<OAuth2Token> _storage;

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
    String url,
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
            url,
            queryParameters: queryParameters,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.post:
          response = await _dio.post(
            url,
            queryParameters: queryParameters,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.put:
          response = await _dio.put(
            url,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.delete:
          response = await _dio.delete(
            url,
            queryParameters: queryParameters,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
        case RequestType.patch:
          response = await _dio.patch(
            url,
            queryParameters: queryParameters,
            data: requestBody,
            options: Options(responseType: ResponseType.json),
          );
      }

      // Mapping the response to Either type.
      return option(
        response,
        (_) => response.statusCode == 200,
      ).match(
        () => Left(UnknownFailure()),
        (response) => Right(response.data as T),
      );
    } on NoNetworkFailure catch (e) {
      return Left(e);
    } on TimeoutFailure catch (e) {
      return Left(e);
    } on SomethingWentWrongFailure catch (e) {
      return Left(e);
    } on InternalServerFailure catch (e) {
      return Left(e);
    }
  }
}
