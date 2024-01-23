import 'package:flutter/cupertino.dart';

import 'appbar_search_bar_settings.dart';

class AppBarActionSettings extends StatelessWidget {
  const AppBarActionSettings({
    required this.child,
    super.key,
    this.behavior = AppBarActionSettingsBehavior.visibleOnFocus,
  });

  final AppBarActionSettingsBehavior behavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
