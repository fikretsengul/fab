// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/freezed_annotation.dart';

part 'o_auth2_token.model.freezed.dart';
part 'o_auth2_token.model.g.dart';

/// Represents a standard OAuth2 token, based on the specification provided by
/// the OAuth 2.0 Authorization Framework.
///
/// This class defines the structure of an OAuth2 token, including all necessary
/// fields typically used in OAuth2 authentication processes.
@freezed
sealed class OAuth2Token with _$OAuth2Token {
  /// Constructs an `OAuth2Token`.
  ///
  /// - [accessToken]: The actual token string used for accessing resources.
  /// - [tokenType]: The type of token, usually "bearer".
  /// - [expiresIn]: The lifetime in seconds of the access token.
  /// - [refreshToken]: The token used to refresh the access token when it expires.
  /// - [scope]: The scope of the access requested, as defined in the OAuth 2.0 specification.
  const factory OAuth2Token({
    /// The access token string as issued by the authorization server.
    required String accessToken,

    /// The type of token this is, typically just the string “bearer”.
    required String tokenType,

    /// If the access token expires, the server should reply
    /// with the duration of time the access token is granted for.
    required int expiresIn,

    /// Token which applications can use to obtain another access token.
    required String refreshToken,

    /// Application scope granted as defined in https://oauth.net/2/scope
    required String scope,
  }) = _OAuth2Token;

  /// Creates an empty `OAuth2Token` instance with default values.
  /// Useful for initializing token values or for testing purposes.
  factory OAuth2Token.empty() => const OAuth2Token(
        accessToken: '',
        tokenType: '',
        expiresIn: 3600,
        refreshToken: '',
        scope: '',
      );

  /// Factory constructor for creating an `OAuth2Token` instance from JSON data.
  factory OAuth2Token.fromJson(Map<String, dynamic> json) => _$OAuth2TokenFromJson(json);
}
