import 'dart:async';

import 'package:flutter_advanced_boilerplate/modules/token_refresh/graphql_token_refresh.dart';
import 'package:fresh_dio/fresh_dio.dart' hide Response;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class GraphQLLink extends Link {
  GraphQLLink({
    bool? isSubscription,
    String? url,
    required GraphQLTokenRefresh tokenRefresh,
  })  : _isSubscription = isSubscription ?? false,
        _url = url ?? '',
        _tokenRefresh = tokenRefresh;

  final bool _isSubscription;
  final String _url;
  final GraphQLTokenRefresh _tokenRefresh;
  SocketClient? _socketClient;

  @override
  Stream<Response> request(
    Request request, [
    Stream<Response> Function(Request)? forward,
  ]) async* {
    final currentToken = await _tokenRefresh.fresh.token;
    final tokenHeader = currentToken != null ? _tokenRefresh.getHeader(currentToken) : const <String, String>{};

    if (_isSubscription) {
      if (_socketClient == null) {
        connectOrReconnect(tokenHeader);
      }

      final subscription = _socketClient!.subscribe(request, true);

      await for (final result in subscription) {
        final nextToken = await _tokenRefresh.fresh.token;
        if (nextToken != null && _tokenRefresh.shouldRefresh(result)) {
          try {
            final refreshedToken = await _tokenRefresh.refreshToken(
              nextToken,
              http.Client(),
            );
            await _tokenRefresh.fresh.setToken(refreshedToken);
            final tokenHeader = _tokenRefresh.getHeader(refreshedToken);
            connectOrReconnect(tokenHeader);

            yield* _socketClient!.subscribe(request, true);
          } on RevokeTokenException catch (_) {
            unawaited(_tokenRefresh.fresh.revokeToken());
            yield result;
          }
        } else {
          yield result;
        }
      }
    } else {
      final updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
        (headers) => HttpLinkHeaders(
          headers: {
            ...headers?.headers ?? <String, String>{},
          }..addAll(tokenHeader),
        ),
      );

      if (forward != null) {
        await for (final result in forward(updatedRequest)) {
          final nextToken = await _tokenRefresh.fresh.token;

          if (nextToken != null && _tokenRefresh.shouldRefresh(result)) {
            try {
              final refreshedToken = await _tokenRefresh.refreshToken(
                nextToken,
                http.Client(),
              );
              await _tokenRefresh.fresh.setToken(refreshedToken);

              yield* forward(
                request.updateContextEntry<HttpLinkHeaders>(
                  (headers) => HttpLinkHeaders(
                    headers: {
                      ...headers?.headers ?? <String, String>{},
                    }..addAll(tokenHeader),
                  ),
                ),
              );
            } on RevokeTokenException catch (_) {
              unawaited(_tokenRefresh.fresh.revokeToken());
              yield result;
            }
          } else {
            yield result;
          }
        }
      }
    }
  }

  void connectOrReconnect(Map<String, String> header) {
    _socketClient?.dispose();
    _socketClient = SocketClient(
      _url,
      config: SocketClientConfig(
        delayBetweenReconnectionAttempts: const Duration(seconds: 2),
        connectFn: (url, protocols) => IOWebSocketChannel.connect(
          url,
          protocols: protocols,
          headers: header,
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    if (_isSubscription) {
      await _socketClient?.dispose();
      _socketClient = null;
    }
  }
}
