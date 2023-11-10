// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons/src/envs/env_dev.dart' as _i4;
import 'package:commons/src/envs/env_prod.dart' as _i5;
import 'package:commons/src/envs/i_env.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _dev = 'dev';
const String _prod = 'prod';

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
    gh.singleton<_i3.IEnv>(
      _i4.EnvDev(),
      registerFor: {_dev},
    );
    gh.singleton<_i3.IEnv>(
      _i5.EnvProd(),
      registerFor: {_prod},
    );
    return this;
  }
}
