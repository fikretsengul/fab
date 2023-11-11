import 'package:deps/packages/injectable.dart';

import 'i_cache.dart';

@Injectable(as: ICache)
class InMemoryCache implements ICache {
  InMemoryCache();

  final Map<String, Object> _map = {};

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

  @override
  void write<T extends Object>({
    required String key,
    required T value,
  }) {
    _map[key] = value;
  }
}
