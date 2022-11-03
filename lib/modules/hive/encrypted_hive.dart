import 'dart:convert';
import 'dart:io';

import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EncryptedHive<T> {
  EncryptedHive._();

  late Box<T> _encryptedHiveBox;

  static Future<EncryptedHive<T>> create<T>(String boxName) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return EncryptedHive<T>._()
        .._encryptedHiveBox = await Hive.openBox<T>(
          'test',
          path: '.',
        );
    }

    final encryptedHive = EncryptedHive<T>._();
    await encryptedHive._load(boxName);

    return encryptedHive;
  }

  Box<T> get encryptedHiveBox => _encryptedHiveBox;

  Future<void> _load(String boxName) async {
    String? encryptedKey;

    try {
      encryptedKey = await getIt<FlutterSecureStorage>().read(key: 'encryptedKey');
    } catch (error) {
      encryptedKey = null;
    }

    if (encryptedKey == null) {
      encryptedKey = base64UrlEncode(Hive.generateSecureKey());
      await getIt<FlutterSecureStorage>().write(
        key: 'encryptedKey',
        value: encryptedKey,
      );
    }

    final encryptionKey = base64Url.decode(encryptedKey);
    final encryptedBox = await Hive.openBox<T>(
      boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    _encryptedHiveBox = encryptedBox;
  }
}
