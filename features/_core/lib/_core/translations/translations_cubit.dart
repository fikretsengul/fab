import 'package:deps/design/design.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_auth/_core/mixins/i18n_mixin.dart';
import 'package:flutter/material.dart';

import '../_i18n/translations.g.dart';
import '../mixins/i18n.mixin.dart';

@lazySingleton
class TranslationsCubit extends HydratedCubit<Locale>
    with DesignTranslationsMixin, CoreTranslationsMixin, AuthTranslationsMixin {
  TranslationsCubit() : super(AppLocaleUtils.findDeviceLocale().flutterLocale);

  void setEN() => emit(AppLocale.en.flutterLocale);
  void setTR() => emit(AppLocale.tr.flutterLocale);

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    return json['locale'] != null ? Locale(json['locale']) : null;
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    return {'locale': state.toString()};
  }
}
