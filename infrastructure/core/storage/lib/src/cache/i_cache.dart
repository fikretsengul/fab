/// Storage for temporary memory; guaranteed to not survive when the application
/// ends. Some [ICache] is only available as long as the user stays on a page.
abstract class ICache {
  void write<T extends Object>({required String key, required T value});

  T? read<T extends Object>({required String key});

  T? remove<T extends Object>({required String key});
}
