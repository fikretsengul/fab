// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

/// `IStorage<T>` is an abstract interface defining a contract for a storage mechanism.
/// It provides a generic approach to handle reading, writing, and deleting values of type `T`.
///
/// This interface can be implemented to provide various storage solutions (like in-memory,
/// persistent, secure, etc.), offering flexibility in how data is managed across different
/// parts of an application.
abstract class IStorage<T> {
  /// Reads a value of type `T` from the storage.
  ///
  /// Returns a `Future` that resolves to the value of type `T` if it exists, otherwise `null`.
  Future<T?> read();

  /// Writes a value of type `T` to the storage.
  ///
  /// [value]: The value of type `T` to be stored.
  ///
  /// Returns a `Future` that completes when the operation is finished.
  Future<void> write(T value);

  /// Deletes the value of type `T` from the storage.
  ///
  /// Returns a `Future` that completes when the deletion operation is finished.
  Future<void> delete();
}
