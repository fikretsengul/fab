// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'package:deps/packages/dio.dart';

import '../../../../storage/storages/i_storage.dart';
import '../../../../storage/storages/token/token_storage_mixin.dart';
import '../../../failures/network_errors.dart';
import '../../../models/o_auth2_token.model.dart';

/// Signature for `shouldRefresh` function in [TokenRefreshInterceptor].
/// Determines whether a token refresh should be attempted based on the response.
typedef ShouldRefresh = bool Function(Response<dynamic>? response);

/// Signature for `refreshToken` function in [TokenRefreshInterceptor].
/// Handles the process of refreshing the authentication token.
typedef RefreshToken<T> = Future<T> Function(T? token, Dio dio);

/// Function to build token headers given a [token].
typedef TokenHeaderBuilder<T> = Map<String, String> Function(T token);

/// A Dio Interceptor for automatic token refresh.
/// Handles transparently refreshing and caching tokens, based on token validity.
///
/// Example usage:
/// ```dart
/// dio.interceptors.add(
///   TokenRefreshInterceptor<OAuth2Token>(
///     tokenStorage: InMemoryTokenStorage(),
///     refreshToken: (token, client) async {...},
///   ),
/// );
/// ```
class DioTokenRefreshInterceptor<T> extends QueuedInterceptor with TokenStorageMixin<T> {
  DioTokenRefreshInterceptor({
    required TokenHeaderBuilder<T> tokenHeader,
    required IStorage<T> tokenStorage,
    required RefreshToken<T> refreshToken,
    ShouldRefresh? shouldRefresh,
    Dio? httpClient,
  })  : _refreshToken = refreshToken,
        _tokenHeader = tokenHeader,
        _shouldRefresh = shouldRefresh ?? shouldRefreshDefault,
        _dio = httpClient ?? Dio() {
    this.tokenStorage = tokenStorage;
  }

  final Dio _dio;
  final RefreshToken<T> _refreshToken;
  final ShouldRefresh _shouldRefresh;
  final TokenHeaderBuilder<T> _tokenHeader;

  // Error, Request, and Response interceptors overridden here...

  /// Static constructor for creating an interceptor specifically for `OAuth2Token`.
  /// Simplifies setting up the interceptor for OAuth2 authentication scenarios.
  ///
  /// Example usage:
  /// ```dart
  /// dio.interceptors.add(
  ///   TokenRefreshInterceptor.oAuth2(
  ///     tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
  ///     refreshToken: (token, client) async {...},
  ///   ),
  /// );
  /// ```
  static DioTokenRefreshInterceptor<OAuth2Token> oAuth2({
    required IStorage<OAuth2Token> tokenStorage,
    required RefreshToken<OAuth2Token> refreshToken,
    ShouldRefresh? shouldRefresh,
    Dio? httpClient,
    TokenHeaderBuilder<OAuth2Token>? tokenHeader,
  }) {
    return DioTokenRefreshInterceptor<OAuth2Token>(
      refreshToken: refreshToken,
      tokenStorage: tokenStorage,
      shouldRefresh: shouldRefresh,
      httpClient: httpClient,
      tokenHeader: tokenHeader ??
          (token) {
            return {
              'authorization': '${token.tokenType} ${token.accessToken}',
            };
          },
    );
  }

  // Private method _tryRefresh for attempting the token refresh...

  /// Default implementation for `shouldRefresh`.
  /// Determines refresh necessity based on a 401 Unauthorized response status.
  static bool shouldRefreshDefault(Response<dynamic>? response) {
    return response?.statusCode == 401;
  }

  /// Intercepts and handles errors during network requests.
  /// Specifically checks for scenarios where a token refresh might be needed,
  /// such as a 401 Unauthorized response.
  ///
  /// [err]: The Dio exception encountered.
  /// [handler]: The error interceptor handler for further error processing.
  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    // Check if the error response meets criteria for a token refresh.
    if (response == null ||
        await token == null ||
        err.error is UnexpectedTokenRefreshNetworkError ||
        !_shouldRefresh(response)) {
      return handler.next(err);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.next(error);
    }
  }

  /// Intercepts and handles outgoing network requests.
  /// Adds authentication token headers to the request if a valid token exists.
  ///
  /// [options]: The request options.
  /// [handler]: The request interceptor handler for further request processing.
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await token;
    final headers = currentToken != null ? _tokenHeader(currentToken) : const <String, String>{};
    options.headers.addAll(headers);
    handler.next(options);
  }

  /// Intercepts and processes responses from network requests.
  /// Checks if a token refresh is needed based on the response.
  ///
  /// [response]: The response from the network request.
  /// [handler]: The response interceptor handler for further response processing.
  @override
  Future<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (await token == null || !_shouldRefresh(response)) {
      return handler.next(response);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.reject(error);
    }
  }

  /// Attempts to refresh the token if the conditions for refresh are met.
  /// This method is called when a refresh is deemed necessary.
  ///
  /// [response]: The original response that triggered the token refresh.
  /// Returns a new response obtained after the token refresh.
  Future<Response<dynamic>> _tryRefresh(Response<dynamic> response) async {
    late final T refreshedToken;
    try {
      refreshedToken = await _refreshToken(await token, _dio);
    } on UnexpectedTokenRefreshNetworkError catch (error) {
      await clearToken();
      throw DioException(
        requestOptions: response.requestOptions,
        error: error,
        response: response,
      );
    }

    await setToken(refreshedToken);
    _dio.options.baseUrl = response.requestOptions.baseUrl;

    return _dio.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers..addAll(_tokenHeader(refreshedToken)),
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError: response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }
}
