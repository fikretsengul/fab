import 'package:flutter/material.dart';

import '../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../models/fab_appbar_settings.dart';
import '../../utils/measures.dart';
import '../../utils/store.dart';
import 'search_bar/search_bar_widget.dart';
import 'widgets/bottom_toolbar_widget.dart';
import 'widgets/large_title_widget.dart';
import 'widgets/top_toolbar_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.measures,
    required this.animationStatus,
    required this.appBarSettings,
    required this.components,
    required this.editingController,
    required this.focusNode,
    required this.keys,
    super.key,
  });

  final Measures measures;
  final SearchBarAnimationStatus animationStatus;
  final FabAppBarSettings appBarSettings;
  final NavigationBarStaticComponents components;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final NavigationBarStaticComponentsKeys keys;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TopToolbarWidget(
          measures: measures,
          keys: keys,
          components: components,
          backIcon: appBarSettings.backIcon,
          animationStatus: animationStatus,
          appBarSettings: appBarSettings,
          middleVisible: appBarSettings.alwaysShowTitle ? null : _store.largeTitleOpacity.value != 0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ValueListenableBuilder(
              valueListenable: _store.searchBarHasFocus,
              builder: (_, searchBarHasFocus, __) {
                return AnimatedContainer(
                  duration: measures.getSearchBarFocusAnimDur,
                  height: searchBarHasFocus ? 0 : measures.getTopToolbarHeightWSafeZone,
                );
              },
            ),
            LargeTitleWidget(
              measures: measures,
              animationStatus: animationStatus,
              appBarSettings: appBarSettings,
              components: components,
            ),
            SearchBarWidget(
              measures: measures,
              searchBar: appBarSettings.searchBar,
              editingController: editingController,
              focusNode: focusNode,
              keys: keys,
            ),
            BottomToolbarWidget(
              measures: measures,
              appBarSettings: appBarSettings,
              toolbar: components.appbarBottom!,
            ),
          ],
        ),
      ],
    );
  }
}
