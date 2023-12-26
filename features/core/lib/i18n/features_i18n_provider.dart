import 'package:auth/core/i18n/translations.g.dart' as auth_tr;
import 'package:flutter/widgets.dart';

class FeaturesI18nProvider extends StatelessWidget {
  const FeaturesI18nProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return auth_tr.TranslationProvider(
      child: child,
    );
  }
}
