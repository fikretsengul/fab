import 'package:auth/i18n/translations.g.dart' as auth_tr;
import 'package:flutter/widgets.dart';

import 'features_translation_combiner.dart';

extension FeaturesTranslationExt on BuildContext {
  FeaturesTranslationCombiner get tr => FeaturesTranslationCombiner(
        auth: auth_tr.Translations.of(this),
      );

  // This changes the locale for all packages,
  // does not matter which package you call it on.
  void setLocaleEn() => auth_tr.LocaleSettings.setLocale(auth_tr.AppLocale.en);
  void setLocaleTr() => auth_tr.LocaleSettings.setLocale(auth_tr.AppLocale.tr);
}
