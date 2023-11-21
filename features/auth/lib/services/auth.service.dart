// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:deps/core/analytics/common.dart';
import 'package:deps/core/analytics/failure.dart';
import 'package:deps/core/networking/networking.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';

import '../models/user.model.dart';
import '../others/failure/failures.dart';

/// `AuthService` provides authentication-related functionalities,
/// including login and logout operations.
@lazySingleton
class AuthService {
  /// Constructs `AuthService` with dependencies on `DioClient` and `DioTokenRefresh`.
  ///
  /// [_dio]: The `DioClient` instance for making network requests.
  /// [_dioTokenRefresh]: The `DioTokenRefresh` instance for handling token refresh.
  AuthService(this._dio, this._dioTokenRefresh);

  // The DioClient instance (unused but can be utilized for network requests).
  // ignore: unused_field
  final DioClient _dio;
  final DioTokenRefresh _dioTokenRefresh;

  /// Handles the login operation with the provided credentials.
  ///
  /// [username]: The username of the user trying to log in.
  /// [password]: The password of the user.
  ///
  /// Returns an `AsyncEither<User>` indicating the result of the login operation.
  /// On successful login, it returns the user details. On failure, it returns an error.
  AsyncEither<User> login(
    String username,
    String password,
  ) async {
    // Example login logic (can be replaced with actual network request logic).
    final isIdPwCorrect = username == 'test' && password == 'test';

    if (isIdPwCorrect) {
      final user = User.empty();

      // Simulating network delay.
      await Future<void>.delayed(const Duration(seconds: 2));
      await _dioTokenRefresh.interceptor.setToken(OAuth2Token.empty());

      return Right(user);
    } else {
      // Return failure if credentials are incorrect.
      return Left(WrongCredentialsFailure());
    }
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
      return Left(UnknownFailure());
    }
  }
}
