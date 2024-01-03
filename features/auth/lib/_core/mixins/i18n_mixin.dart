import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../_i18n/translations.g.dart';

mixin AuthTranslationsMixin on Cubit<Locale> {
  Translations get auth => AppLocaleUtils.parse(state.toString()).build();
}
