import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../_i18n/translations.g.dart';

mixin DesignTranslationsMixin on Cubit<Locale> {
  Translations get design => AppLocaleUtils.parse(state.toString()).build();
}
