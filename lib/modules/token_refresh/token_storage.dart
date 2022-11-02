import 'dart:convert';

import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/user_model.dart';
import 'package:flutter_advanced_boilerplate/modules/encrypted_hive/encrypted_hive.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenStorage)
@preResolve
class HiveTokenStorage extends TokenStorage<AuthModel> {
  HiveTokenStorage._(this._hiveBox);

  final Box<String> _hiveBox;

  @override
  Future<void> delete() async {
    await _hiveBox.putAll(
      {
        'tokenType': 'Bearer ',
        'accessToken': '',
        'refreshToken': '',
        'user': '',
      },
    );
  }

  @override
  Future<AuthModel?> read() async {
    final tokenType = _hiveBox.get('tokenType', defaultValue: 'Bearer ')!;
    final accessToken = _hiveBox.get('accessToken', defaultValue: '')!;
    final refreshToken = _hiveBox.get('refreshToken', defaultValue: '')!;
    final user = _hiveBox.get('user', defaultValue: '')!;

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
      {
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
