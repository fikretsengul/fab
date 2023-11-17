// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';

import 'i_cache.dart';

/// `InMemoryCache` provides an implementation of `ICache` for storing data in memory.
/// It uses a Dart `Map` to store and retrieve values. The stored data is not persistent
/// and is available only for the duration of the application runtime.
@Injectable(as: ICache)
class InMemoryCache implements ICache {
  /// Constructs an `InMemoryCache` instance.
  InMemoryCache();

  /// The internal map that holds the cached data.
  final Map<String, Object> _map = {};

  /// Reads a value from the cache associated with the specified key.
  ///
  /// [T]: The type of the value being read.
  /// [key]: The key associated with the value to be read.
  ///
  /// Returns the value if it exists and matches the type `T`, otherwise `null`.
  @override
  T? read<T extends Object>({
    required String key,
  }) {
    final value = _map[key];
    if (value is T) {
      return value;
    }

    return null;
  }

  /// Removes a value from the cache associated with the specified key.
  ///
  /// [T]: The type of the value being removed.
  /// [key]: The key associated with the value to be removed.
  ///
  /// Returns the removed value if it exists and matches the type `T`, otherwise `null`.
  @override
  T? remove<T extends Object>({
    required String key,
  }) {
    final value = _map.remove(key);
    if (value is T) {
      return value;
    }

    return null;
  }

  /// Writes a value to the cache associated with the specified key.
  ///
  /// [T]: The type of the value being stored.
  /// [key]: The key to associate with the value.
  /// [value]: The value to store in the cache.
  @override
  void write<T extends Object>({
    required String key,
    required T value,
  }) {
    _map[key] = value;
  }
}
