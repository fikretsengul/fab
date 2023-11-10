// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:networking/networking.dart' as _i7;
import 'package:storage/src/cache/i_cache.dart' as _i4;
import 'package:storage/src/cache/in_memory_cache.dart' as _i5;
import 'package:storage/src/di/configure_di.dart' as _i9;
import 'package:storage/src/storage/i_storage.dart' as _i6;
import 'package:storage/src/storage/token/secure_token_storage.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final flutterSecureStorageModule = _$FlutterSecureStorageModule();
    gh.factory<_i3.FlutterSecureStorage>(
        () => flutterSecureStorageModule.secureStorage);
    gh.factory<_i4.ICache>(() => _i5.InMemoryCache());
    gh.lazySingleton<_i6.IStorage<_i7.OAuth2Token>>(
        () => _i8.SecureTokenStorage(gh<_i3.FlutterSecureStorage>()));
    return this;
  }
}

class _$FlutterSecureStorageModule extends _i9.FlutterSecureStorageModule {}
