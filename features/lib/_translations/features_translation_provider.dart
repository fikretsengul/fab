import 'package:auth/i18n/translations.g.dart' as auth_tr;
import 'package:flutter/widgets.dart';

class FeaturesTranslationProvider extends StatelessWidget {
  FeaturesTranslationProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return auth_tr.TranslationProvider(
      child: child,
    );
  }
}
