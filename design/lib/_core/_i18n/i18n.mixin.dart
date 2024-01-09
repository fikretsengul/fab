import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'translations.g.dart';

mixin DesignTranslationMixin on Cubit<Locale> {
  Translations get design => AppLocaleUtils.parse(state.toString()).build();
}
