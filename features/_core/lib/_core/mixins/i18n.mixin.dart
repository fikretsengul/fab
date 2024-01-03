import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../_i18n/translations.g.dart';

mixin CoreTranslationsMixin on Cubit<Locale> {
  Translations get core => AppLocaleUtils.parse(state.toString()).build();
}
