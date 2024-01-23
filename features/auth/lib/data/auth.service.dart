// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';

import '../domain/failures/auth.failures.dart';

@lazySingleton
class AuthService {
  AuthService(this._client);

  final INetworkClient _client;

  AsyncEither<UserModel> login(
    String email,
    String password,
  ) async {
    final response = await _client.invoke<void, Map<String, dynamic>>(
      '/auth/login',
      RequestType.post,
      requestBody: {
        'email': email,
        'password': password,
      },
    );

    return response.fold(
      (failure) {
        if (failure is UnauthorizedNetworkFailure) {
          return Left(WrongCredentialsAuthFailure());
        }

        return Left(failure);
      },
      (tokens) async {
        await _client.tokenStorage.setToken(
          OAuth2Token(
            accessToken: tokens['access_token'],
            refreshToken: tokens['refresh_token'],
            tokenType: 'Bearer',
            expiresIn: 3600,
            scope: '',
          ),
        );

        return _client.invoke<void, UserModel>(
          '/auth/profile',
          RequestType.get,
          fromJson: UserModel.fromJson,
        );
      },
    );
  }
}
