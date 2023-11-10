import 'dart:io';

import 'package:commons/envs.dart';
import 'package:commons/errors.dart';
import 'package:commons/types.dart';
import 'package:deps/dio.dart';
import 'package:deps/fpdart.dart';
import 'package:deps/injectable.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:storage/storage.dart';

import 'dio_token_refresh.dart';
import 'exceptions/dio_exceptions.dart';
import 'i_network_client.dart';
import 'interceptors/internal_server_interceptor.dart';
import 'interceptors/no_network_interceptor.dart';
import 'interceptors/something_went_wrong_interceptor.dart';
import 'interceptors/timeout_interceptor.dart';
import 'token/o_auth2_token.dart';

@lazySingleton
class DioClient implements INetworkClient {
  DioClient(this._env, this._dio, this._storage) {
    _dio
      ..options.baseUrl = _env.apiUrl
      ..options.headers['Accept-Language'] = kIsWeb ? 'en-US' : Platform.localeName.substring(0, 2)
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..interceptors.add(NoNetworkInterceptor())
      ..interceptors.add(TimeoutInterceptor())
      ..interceptors.add(SomethingWentWrongInterceptor())
      ..interceptors.add(InternalServerInterceptor())
      ..interceptors.add(DioTokenRefresh(_storage).interceptor)
      ..interceptors.add(
        RetryInterceptor(
          dio: _dio,
/*           logPrint: _talker.log, */
          retries: 2,
        ),
      );

    if (_env.isDebug) {
/*       _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      ); */
    }
  }

  final Dio _dio;
  final IEnv _env;
/*   final Talker _talker; */
  final IStorage<OAuth2Token> _storage;

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
