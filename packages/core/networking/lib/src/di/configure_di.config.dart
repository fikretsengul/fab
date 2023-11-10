// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons/envs.dart' as _i5;
import 'package:deps/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i9;
import 'package:networking/src/di/configure_di.dart' as _i10;
import 'package:networking/src/dio_client.dart' as _i4;
import 'package:networking/src/dio_token_refresh.dart' as _i8;
import 'package:networking/src/token/o_auth2_token.dart' as _i7;
import 'package:storage/storage.dart' as _i6;

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
    final dioModule = _$DioModule();
    final internetConnectionModule = _$InternetConnectionModule();
    gh.factory<_i3.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i4.DioClient>(() => _i4.DioClient(
          gh<_i5.IEnv>(),
          gh<_i3.Dio>(),
          gh<_i6.IStorage<_i7.OAuth2Token>>(),
        ));
    gh.lazySingleton<_i8.DioTokenRefresh>(
        () => _i8.DioTokenRefresh(gh<_i6.IStorage<_i7.OAuth2Token>>()));
    gh.factory<_i9.InternetConnection>(
        () => internetConnectionModule.internetConnection);
    return this;
  }
}

class _$DioModule extends _i10.DioModule {}

class _$InternetConnectionModule extends _i10.InternetConnectionModule {}
