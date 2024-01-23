// ignore_for_file: avoid_returning_widgets
import 'package:flutter/cupertino.dart';

import '../../../../models/appbar_action_settings.dart';
import '../../../../models/appbar_search_bar_settings.dart';

class SearchActionsWidget extends StatelessWidget {
  const SearchActionsWidget({
    required this.actions,
    required this.animationDuration,
    required this.searchBarHasFocus,
    super.key,
  });

  final List<AppBarActionSettings> actions;
  final Duration animationDuration;
  final bool searchBarHasFocus;

  Widget _buildAnimatedCrossFade(List<Widget> children, CrossFadeState state) {
    return AnimatedCrossFade(
      firstChild: Center(child: Row(children: children)),
      secondChild: const SizedBox(),
      crossFadeState: searchBarHasFocus ? state : CrossFadeState.showSecond,
      duration: animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final searchAction in actions)
          if (searchAction.behavior == AppBarActionSettingsBehavior.alwaysVisible) searchAction else const SizedBox(),
        _buildAnimatedCrossFade(
          actions.where((e) => e.behavior == AppBarActionSettingsBehavior.visibleOnFocus).toList(),
          CrossFadeState.showFirst,
        ),
        _buildAnimatedCrossFade(
          actions.where((e) => e.behavior == AppBarActionSettingsBehavior.visibleOnUnFocus).toList(),
          CrossFadeState.showSecond,
        ),
      ],
    );
  }
}
