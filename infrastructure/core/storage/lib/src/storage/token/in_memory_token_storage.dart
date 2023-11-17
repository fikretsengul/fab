// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../i_storage.dart';

/// `InMemoryTokenStorage<T>` is an implementation of `IStorage<T>` that stores the token in memory.
/// This class provides a simple and straightforward way to handle token storage for the duration
/// of the application's runtime, with no persistence beyond that.
class InMemoryTokenStorage<T> implements IStorage<T> {
  /// The token stored in memory.
  T? _token;

  /// Deletes the token from memory.
  ///
  /// This method sets the in-memory token value to `null`, effectively removing it.
  @override
  Future<void> delete() async {
    _token = null;
  }

  /// Reads the token from memory.
  ///
  /// Returns a `Future` that resolves to the token if it exists, otherwise `null`.
  @override
  Future<T?> read() async {
    return _token;
  }

  /// Writes the token to memory.
  ///
  /// [token]: The token of type `T` to be stored in memory.
  ///
  /// This method sets the in-memory token value to the provided token.
  @override
  Future<void> write(T token) async {
    _token = token;
  }
}
