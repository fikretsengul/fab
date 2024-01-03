import 'package:flutter/widgets.dart';

import 'translations.g.dart';

extension DesignI18nExt on BuildContext {
  // This changes the locale for all packages,
  // does not matter which package you call it on.
  void useDeviceLocale() => LocaleSettings.useDeviceLocale();
  void setLocaleEn() => LocaleSettings.setLocale(AppLocale.en);
  void setLocaleTr() => LocaleSettings.setLocale(AppLocale.tr);

  Translations get designTr => Translations.of(this);
}
