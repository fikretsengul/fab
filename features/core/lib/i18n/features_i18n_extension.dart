import 'package:feature_auth/core/i18n/translations.g.dart' as auth_tr;
import 'package:flutter/widgets.dart';

extension FeaturesI18nExt on BuildContext {
  auth_tr.Translations get authTr => auth_tr.Translations.of(this);
}
