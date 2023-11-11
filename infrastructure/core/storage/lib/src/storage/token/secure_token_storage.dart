import 'dart:convert';

import 'package:deps/core/networking/networking.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      return OAuth2Token.fromJson(jsonDecode(token));
    }

    return null;
  }

  @override
  Future<void> write(OAuth2Token value) async {
    await _secureStorage.write(
      key: _key,
      value: jsonEncode(value.toJson()),
    );
  }
}
