import 'dart:convert';

import 'package:deps/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:networking/networking.dart';

import '../i_storage.dart';

@LazySingleton(as: IStorage<OAuth2Token>)
class SecureTokenStorage extends IStorage<OAuth2Token> {
  SecureTokenStorage(this._secureStorage);

  final String _key = 'secure_token_storage';
  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _key);
  }

  @override
  Future<OAuth2Token?> read() async {
    final token = await _secureStorage.read(key: _key);

    if (token != null) {
      final tokenJson = jsonDecode(token) as Map<String, dynamic>;
      return OAuth2Token(
        accessToken: tokenJson['accessToken'] as String,
        tokenType: tokenJson['tokenType'] as String,
        expiresIn: tokenJson['expiresIn'] as int,
        refreshToken: tokenJson['refreshToken'] as String,
        scope: tokenJson['scope'] as String,
      );
    }

    return null;
  }

  @override
  Future<void> write(OAuth2Token value) async {
    await _secureStorage.write(
      key: _key,
      value: jsonEncode(value),
    );
  }
}
