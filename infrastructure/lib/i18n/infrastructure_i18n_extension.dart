import 'package:flutter/widgets.dart';

import 'translations.g.dart';

extension InfrastructureI18nExt on BuildContext {
  Translations get infrastructureTr => Translations.of(this);
}
