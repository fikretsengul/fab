import 'package:flutter/cupertino.dart';

import '../../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../../models/fab_appbar_search_bar_settings.dart';
import '../../../models/fab_appbar_settings.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';

class LargeTitleWidget extends StatelessWidget {
  const LargeTitleWidget({
    required this.measures,
    required this.animationStatus,
    required this.appBarSettings,
    required this.components,
    super.key,
  });

  final Measures measures;
  final SearchBarAnimationStatus animationStatus;
  final FabAppBarSettings appBarSettings;
  final NavigationBarStaticComponents components;

  Store get _store => Store.instance();

  double get _largeTitleOpacity => _store.largeTitleOpacity.value == 0 ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: appBarSettings.largeTitle.padding,
      child: AnimatedOpacity(
        duration: animationStatus == SearchBarAnimationStatus.paused
            ? const Duration(milliseconds: 250)
            : measures.getLargeTitleOpacityAnimDur,
        opacity: _store.searchBarHasFocus.value
            ? (appBarSettings.searchBar.animationBehavior == SearchBarAnimationBehavior.top ? 0 : _largeTitleOpacity)
            : _largeTitleOpacity,
        child: AnimatedContainer(
          height: _store.searchBarHasFocus.value
              ? (appBarSettings.searchBar.animationBehavior == SearchBarAnimationBehavior.top
                  ? 0
                  : _store.largeTitleHeight.value)
              : _store.largeTitleHeight.value,
          duration:
              animationStatus == SearchBarAnimationStatus.paused ? Duration.zero : measures.getSearchBarFocusAnimDur,
          child: Padding(
            padding: EdgeInsets.only(bottom: measures.largeTitleHeight > 0 ? 4.0 : 0),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Transform.scale(
                          scale: _store.largeTitleScale.value,
                          filterQuality: FilterQuality.high,
                          alignment: Alignment.bottomLeft,
                          child: components.largeTitle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      components.largeTitleActions!,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
