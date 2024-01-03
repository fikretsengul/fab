import 'package:flutter/widgets.dart';

import 'translations.g.dart';

class DesignI18nProvider extends StatelessWidget {
  const DesignI18nProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: child,
    );
  }
}
