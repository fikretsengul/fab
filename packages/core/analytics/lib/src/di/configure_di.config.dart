// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:analytics/analytics.dart' as _i9;
import 'package:analytics/logger.dart' as _i8;
import 'package:analytics/src/analytics/analytics.dart' as _i3;
import 'package:analytics/src/di/configure_di.dart' as _i10;
import 'package:analytics/src/logger/logger.dart' as _i5;
import 'package:analytics/src/observers/failure_observer.dart' as _i6;
import 'package:commons/envs.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:talker_flutter/talker_flutter.dart' as _i4;

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
    final talkerModule = _$TalkerModule();
    gh.lazySingleton<_i3.Analytics>(() => _i3.Analytics());
    gh.factory<_i4.Talker>(() => talkerModule.talker());
    gh.lazySingleton<_i5.Logger>(() => _i5.Logger(gh<_i4.Talker>()));
    gh.lazySingleton<_i6.FailureObserver>(() => _i6.FailureObserver(
          gh<_i7.IEnv>(),
          gh<_i8.Logger>(),
          gh<_i9.Analytics>(),
        ));
    return this;
  }
}

class _$TalkerModule extends _i10.TalkerModule {}
