import 'dart:async';

/// An interface which must be implemented to
/// read, write, and delete a `Value`.
abstract class IStorage<T> {
  Future<T?> read();

  Future<void> write(T value);

  Future<void> delete();
}
