import 'package:flutter/cupertino.dart';

import 'fab_appbar_search_bar_settings.dart';

class FabAppBarActionSettings extends StatelessWidget {
  const FabAppBarActionSettings({
    required this.child,
    super.key,
    this.behavior = FabAppBarActionSettingsBehavior.visibleOnFocus,
  });

  final FabAppBarActionSettingsBehavior behavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
