import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EncryptedHive<T> {
  EncryptedHive._();

  late Box<T> _hiveBox;

  static Future<EncryptedHive<T>> create<T>(String boxName) async {
    final encryptedHive = EncryptedHive<T>._();
    await encryptedHive._load(boxName);

    return encryptedHive;
  }

  Box<T> get box => _hiveBox;

  Future<void> _load(String boxName) async {
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    String? key;

    try {
      // This try catch is for a crash that happens on some android devices.
      key = await secureStorage.read(key: 'key');
    } catch (error) {
      key = null;
    }

    if (key == null) {
      key = base64UrlEncode(Hive.generateSecureKey());
      await secureStorage.write(
        key: 'key',
        value: key,
      );
    }

    final encryptionKey = base64Url.decode(key);

    final encryptedBox = await Hive.openBox<T>(
      boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    _hiveBox = encryptedBox;
  }
}
