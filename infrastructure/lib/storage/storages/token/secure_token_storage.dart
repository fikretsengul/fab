// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:deps/packages/flutter_secure_storage.dart';
import 'package:deps/packages/injectable.dart';

import '../../../networking/models/o_auth2_token.model.dart';
import '../i_storage.dart';

/// `SecureTokenStorage` provides a secure implementation of `IStorage<OAuth2Token>`
/// using `FlutterSecureStorage`. This class handles the storing, retrieving, and
/// deleting of OAuth2 tokens in a secure and encrypted manner.
@LazySingleton(as: IStorage<OAuth2Token>)
class SecureTokenStorage extends IStorage<OAuth2Token> {
  /// Constructs a `SecureTokenStorage` with an instance of `FlutterSecureStorage`.
  SecureTokenStorage(this._secureStorage);

  /// The key under which the token is stored in the secure storage.
  final String _key = 'secure_token_storage';

  /// The instance of `FlutterSecureStorage` used for secure operations.
  final FlutterSecureStorage _secureStorage;

  /// Deletes the OAuth2 token from secure storage.
  ///
  /// Asynchronously removes the token associated with [_key] from secure storage.
  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _key);
  }

  /// Reads the OAuth2 token from secure storage.
  ///
  /// Retrieves and decodes the token stored under [_key]. If the token exists,
  /// it is decoded from JSON and returned as an `OAuth2Token` instance.
  ///
  /// Returns `null` if no token is found.
  @override
  Future<OAuth2Token?> read() async {
    try {
      final token = await _secureStorage.read(key: _key);

      if (token != null) {
        return OAuth2Token.fromJson(jsonDecode(token));
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Writes the OAuth2 token to secure storage.
  ///
  /// [value]: The `OAuth2Token` instance to be stored.
  /// Encodes the token as JSON and writes it to secure storage under [_key].
  @override
  Future<void> write(OAuth2Token value) async {
    await _secureStorage.write(
      key: _key,
      value: jsonEncode(value.toJson()),
    );
  }
}
