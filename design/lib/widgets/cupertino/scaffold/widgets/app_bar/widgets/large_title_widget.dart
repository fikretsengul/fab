import 'package:flutter/cupertino.dart';

import '../../../../overridens/overriden_transitionable_navigation_bar.dart';
import '../../../models/appbar_search_bar_settings.dart';
import '../../../models/appbar_settings.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';

class LargeTitleWidget extends StatelessWidget {
  const LargeTitleWidget({
    required this.animationStatus,
    required this.measures,
    required this.appBar,
    required this.largeTitleHeight,
    required this.scaleTitle,
    required this.components,
    required this.titleOpacity,
    super.key,
  });

  final SearchBarAnimationStatus animationStatus;
  final AppBarSettings appBar;
  final NavigationBarStaticComponents components;
  final double largeTitleHeight;
  final Measures measures;
  final double scaleTitle;
  final double titleOpacity;

  Store get _store => Store.instance();

  double get _opacity => titleOpacity == 0 ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: appBar.largeTitle!.padding,
      child: AnimatedOpacity(
        duration: animationStatus == SearchBarAnimationStatus.paused
            ? const Duration(milliseconds: 250)
            : measures.titleOpacityAnimationDuration,
        opacity: _store.searchBarHasFocus.value
            ? (appBar.searchBar!.animationBehavior == SearchBarAnimationBehavior.top ? 0 : _opacity)
            : _opacity,
        child: AnimatedContainer(
          height: _store.searchBarHasFocus.value
              ? (appBar.searchBar!.animationBehavior == SearchBarAnimationBehavior.top ? 0 : largeTitleHeight)
              : largeTitleHeight,
          duration:
              animationStatus == SearchBarAnimationStatus.paused ? Duration.zero : measures.searchBarAnimationDuration,
          child: Padding(
            padding: EdgeInsets.only(bottom: measures.largeTitleContainerHeight > 0 ? 8.0 : 0),
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
                          scale: scaleTitle,
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
