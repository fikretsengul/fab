// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// `ICache` is an abstract interface class that defines the contract for temporary memory storage.
/// It guarantees that the stored data does not persist after the application ends.
/// In some cases, the data in `ICache` is available only while the user remains on a specific page.
abstract interface class ICache {
  /// Writes a value to the cache associated with a specified key.
  ///
  /// [T]: The type of the value being stored.
  /// [key]: A unique string key to identify the stored value.
  /// [value]: The value to be stored in the cache.
  void write<T extends Object>({required String key, required T value});

  /// Reads a value from the cache based on the specified key.
  ///
  /// [T]: The expected type of the value being read.
  /// [key]: The key associated with the value to be read.
  ///
  /// Returns the value if it exists, otherwise `null`.
  T? read<T extends Object>({required String key});

  /// Removes a value from the cache based on the specified key.
  ///
  /// [T]: The expected type of the value being removed.
  /// [key]: The key associated with the value to be removed.
  ///
  /// Returns the removed value if it exists, otherwise `null`.
  T? remove<T extends Object>({required String key});
}
