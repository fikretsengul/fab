import 'package:flutter/material.dart';

import '../../../models/fab_appbar_settings.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';

class BottomToolbarWidget extends StatelessWidget {
  const BottomToolbarWidget({
    required this.appBarSettings,
    required this.measures,
    required this.toolbar,
    super.key,
  });

  final FabAppBarSettings appBarSettings;
  final Measures measures;
  final KeyedSubtree toolbar;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store.searchBarHasFocus,
      builder: (_, searchBarHasFocus, __) {
        return Align(
          alignment: Alignment.bottomLeft,
          child: AnimatedSwitcher(
            duration: measures.getSlowAnimationDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.linear,
                  ),
                  axisAlignment: -1,
                  child: child,
                ),
              );
            },
            child: searchBarHasFocus
                ? appBarSettings.searchBar!.toolbar!.enabled
                    ? Container(
                        key: const ValueKey<int>(0),
                        width: double.infinity,
                        height: appBarSettings.searchBar!.toolbar!.height,
                        padding: appBarSettings.searchBar!.toolbar!.padding,
                        child: appBarSettings.searchBar!.toolbar!.child,
                      )
                    : const SizedBox(key: ValueKey<int>(1))
                : Container(
                    key: const ValueKey<int>(2),
                    width: double.infinity,
                    height: appBarSettings.toolbar!.height,
                    padding: appBarSettings.toolbar!.padding,
                    child: appBarSettings.toolbar!.child,
                  ),
          ),
        );
      },
    );
  }
}
