// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';

/// `AuthService` provides authentication-related functionalities,
/// including login and logout operations.
@lazySingleton
class AuthService {
  /// Constructs `AuthService` with dependencies on `DioClient` and `DioTokenRefresh`.
  ///
  /// [_dio]: The `DioClient` instance for making network requests.
  /// [_dioTokenRefresh]: The `DioTokenRefresh` instance for handling token refresh.
  AuthService(this._client);

  // The DioClient instance (unused but can be utilized for network requests).
  // ignore: unused_field
  final INetworkClient _client;

  /// Handles the login operation with the provided credentials.
  ///
  /// [username]: The username of the user trying to log in.
  /// [password]: The password of the user.
  ///
  /// Returns an `AsyncEither<User>` indicating the result of the login operation.
  /// On successful login, it returns the user details. On failure, it returns an error.
  AsyncEither<UserModel> login(
    String email,
    String password,
  ) async {
    await _client.tokenStorage.setToken(OAuth2Token.empty());

    return Right(
      UserModel(
        id: 1,
        email: 'test@gmail.com',
        name: 'Test User',
        role: UserRoleEnum.admin,
        avatar: 'https://picsum.photos/200/300',
      ),
    );
/*     final response = await _client.invoke<Map<String, dynamic>>(
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
      (tokens) {
        logger.log(tokens, 'Tokens:');

        return Right(UserModel.empty());
      },
    ); */
  }

  /// Handles the logout operation.
  ///
  /// This method should include the logic for logging out the user.
  /// On successful logout, it returns a void right value. On failure, it returns an error.
  AsyncEither<void> logout() async {
    try {
      // Implement custom logout operation here.

      return const Right(null);
    } catch (e) {
      // Return failure if logout operation fails.
      return Left(UnexpectedError());
    }
  }
}
