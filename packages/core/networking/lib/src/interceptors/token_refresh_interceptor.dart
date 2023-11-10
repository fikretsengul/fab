import 'package:deps/dio.dart';
import 'package:storage/storage.dart';

import '../token/o_auth2_token.dart';

/// An Exception that should be thrown when overriding `refreshToken` if the
/// refresh fails and should result in a force-logout.
class RevokeTokenException implements Exception {}

/// Signature for `shouldRefresh` on [TokenRefreshInterceptor].
typedef ShouldRefresh = bool Function(Response<dynamic>? response);

/// Signature for `refreshToken` on [TokenRefreshInterceptor].
typedef RefreshToken<T> = Future<T> Function(T? token, Dio dio);

/// Function responsible for building the token header(s) give a [token].
typedef TokenHeaderBuilder<T> = Map<String, String> Function(
  T token,
);

/// A Dio Interceptor for automatic token refresh.
/// Requires a concrete implementation of [IStorage] and [RefreshToken].
/// Handles transparently refreshing/caching tokens.
///
/// ```dart
/// dio.interceptors.add(
///   TokenRefreshInterceptor<OAuth2Token>(
///     tokenStorage: InMemoryTokenStorage(),
///     refreshToken: (token, client) async {...},
///   ),
/// );
/// ```
class TokenRefreshInterceptor<T> extends QueuedInterceptor with TokenStorageMixin<T> {
  TokenRefreshInterceptor({
    required TokenHeaderBuilder<T> tokenHeader,
    required IStorage<T> tokenStorage,
    required RefreshToken<T> refreshToken,
    ShouldRefresh? shouldRefresh,
    Dio? httpClient,
  })  : _refreshToken = refreshToken,
        _tokenHeader = tokenHeader,
        _shouldRefresh = shouldRefresh ?? _defaultShouldRefresh,
        _dio = httpClient ?? Dio() {
    this.tokenStorage = tokenStorage;
  }

  final Dio _dio;
  final RefreshToken<T> _refreshToken;
  final ShouldRefresh _shouldRefresh;
  final TokenHeaderBuilder<T> _tokenHeader;

  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response == null || await token == null || err.error is RevokeTokenException || !_shouldRefresh(response)) {
      return handler.next(err);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.next(error);
    }
  }

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

  /// A constructor that returns a [TokenRefreshInterceptor] interceptor
  /// that uses an [OAuth2Token] token.
  ///
  /// ```dart
  /// dio.interceptors.add(
  ///   TokenRefreshInterceptor.oAuth2(
  ///     tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
  ///     refreshToken: (token, client) async {...},
  ///   ),
  /// );
  /// ```
  static TokenRefreshInterceptor<OAuth2Token> oAuth2({
    required IStorage<OAuth2Token> tokenStorage,
    required RefreshToken<OAuth2Token> refreshToken,
    ShouldRefresh? shouldRefresh,
    Dio? httpClient,
    TokenHeaderBuilder<OAuth2Token>? tokenHeader,
  }) {
    return TokenRefreshInterceptor<OAuth2Token>(
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

  Future<Response<dynamic>> _tryRefresh(Response<dynamic> response) async {
    late final T refreshedToken;
    try {
      refreshedToken = await _refreshToken(await token, _dio);
    } on RevokeTokenException catch (error) {
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

  static bool _defaultShouldRefresh(Response<dynamic>? response) {
    return response?.statusCode == 401;
  }
}
