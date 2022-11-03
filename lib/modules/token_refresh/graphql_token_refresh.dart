import 'dart:convert';

import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/env_model.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' hide Response;
import 'package:injectable/injectable.dart';

@lazySingleton
class GraphQLTokenRefresh {
  GraphQLTokenRefresh(this._env, this._secureStorage) {
    _fresh = FreshLink<AuthModel>(
      tokenStorage: _secureStorage,
      refreshToken: refreshToken,
      shouldRefresh: shouldRefresh,
      tokenHeader: (token) {
        return {
          'authorization': '${token?.tokenType} ${token?.accessToken}',
        };
      },
    );
  }

  final EnvModel _env;
  final TokenStorage<AuthModel> _secureStorage;
  late final FreshLink<AuthModel> _fresh;

  FreshLink<AuthModel> get fresh => _fresh;

  Future<AuthModel> refreshToken(
    AuthModel? token,
    Client client,
  ) async {
    if (token == null) {
      throw RevokeTokenException();
    }

    final response = await client.post(
      Uri.parse("https://${"${_env.graphQLApiUrl}/token/refresh?userid="}${token.user.id}"),
      body: jsonEncode(<String, String>{'refresh_token': token.refreshToken}),
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw RevokeTokenException();
    }

    return AuthModel(
      tokenType: token.tokenType,
      accessToken: body['access_token'] as String,
      refreshToken: body['refresh_token'] as String,
      user: token.user,
    );
  }

  bool shouldRefresh(Response response) {
    return response.errors != null &&
        response.errors!
            .where(
              (e) => e.extensions!['statusCode'] != null && e.extensions!['statusCode'] == 403,
            )
            .toList()
            .isNotEmpty;
  }

  Map<String, String> getHeader(AuthModel token) {
    return {
      'authorization': '${token.tokenType} ${token.accessToken}',
    };
  }
}
