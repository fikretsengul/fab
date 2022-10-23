import 'dart:convert';

import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/user_model.dart';
import 'package:flutter_advanced_boilerplate/modules/encrypted_hive/encrypted_hive.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
@preResolve
class HiveTokenStorage extends TokenStorage<AuthModel> {
  HiveTokenStorage._(this._hiveBox);

  final Box<dynamic> _hiveBox;

  @override
  Future<void> delete() async {
    await _hiveBox.putAll(
      <String, dynamic>{
        'tokenType': 'Bearer ',
        'accessToken': '',
        'refreshToken': '',
        'user': '',
      },
    );
  }

  @override
  Future<AuthModel?> read() async {
    final tokenType = _hiveBox.get('tokenType', defaultValue: 'Bearer ') as String;
    final accessToken = _hiveBox.get('accessToken', defaultValue: '') as String;
    final refreshToken = _hiveBox.get('refreshToken', defaultValue: '') as String;
    final user = _hiveBox.get('user', defaultValue: '') as String;

    if (tokenType.isNotEmpty && accessToken.isNotEmpty && refreshToken.isNotEmpty && user.isNotEmpty) {
      return AuthModel(
        tokenType: tokenType,
        accessToken: accessToken,
        refreshToken: refreshToken,
        user: UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>),
      );
    }

    return null;
  }

  @override
  Future<void> write(AuthModel token) async {
    await _hiveBox.putAll(
      <String, dynamic>{
        'tokenType': token.tokenType,
        'accessToken': token.accessToken,
        'refreshToken': token.refreshToken,
        'user': jsonEncode(token.user.toJson()),
      },
    );
  }

  @factoryMethod
  static Future<HiveTokenStorage> create() async {
    final box = (await EncryptedHive.create<String>('tokens')).box;

    return HiveTokenStorage._(box);
  }
}
