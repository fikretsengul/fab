// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/src/bloc/auth.bloc.dart' as _i3;
import 'package:auth/src/bloc/login.bloc.dart' as _i6;
import 'package:auth/src/service/auth.service.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:networking/networking.dart' as _i4;

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
    gh.lazySingleton<_i3.AuthBloc>(
        () => _i3.AuthBloc(gh<_i4.DioTokenRefresh>()));
    gh.lazySingleton<_i5.AuthService>(
        () => _i5.AuthService(gh<_i4.DioClient>()));
    gh.lazySingleton<_i6.LoginBloc>(() => _i6.LoginBloc(gh<_i5.AuthService>()));
    return this;
  }
}
