import 'dart:convert';

import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenStorage)
class SecureAuthStorage extends TokenStorage<AuthModel> {
  SecureAuthStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: 'auth_storage');
  }

  @override
  Future<AuthModel?> read() async {
    final auth = await _secureStorage.read(key: 'auth_storage');

    if (auth != null) {
      return AuthModel.fromJson(jsonDecode(auth) as Map<String, dynamic>);
    }

    return null;
  }

  @override
  Future<void> write(AuthModel token) async {
    await _secureStorage.write(key: 'auth_storage', value: jsonEncode(token.toJson()));
  }
}
