// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_auth/_core/_i18n/i18n_mixin.dart';
import 'package:feature_products/_core/_i18n/i18n_mixin.dart';
import 'package:feature_settings/_core/_i18n/i18n_mixin.dart';
import 'package:flutter/material.dart';

import '../../_core/_i18n/i18n.mixin.dart';
import '../../_core/_i18n/translations.g.dart';

@lazySingleton
class TranslationCubit extends HydratedCubit<Locale>
    with
        DesignTranslationMixin,
        CoreTranslationMixin,
        AuthTranslationMixin,
        ProductsTranslationMixin,
        SettingsTranslationMixin {
  TranslationCubit() : super(AppLocaleUtils.findDeviceLocale().flutterLocale);

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
