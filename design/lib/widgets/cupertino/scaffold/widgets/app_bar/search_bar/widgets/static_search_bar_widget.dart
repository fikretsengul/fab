import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../_core/constants/app_theme.dart';
import '../../../../models/appbar_action_settings.dart';
import '../../../../models/appbar_search_bar_settings.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/measures.dart';
import '../../../../utils/store.dart';
import '../../../transitionable_navigation_bar.dart';

class StaticSearchBarWidget extends StatelessWidget {
  const StaticSearchBarWidget({
    required this.keys,
    required this.searchBar,
    required this.measures,
    required this.opacity,
    required this.focusNode,
    required this.editingController,
    required this.searchBarFocusThings,
    super.key,
  });

  final TextEditingController editingController;
  final FocusNode focusNode;
  final NavigationBarStaticComponentsKeys keys;
  final Measures measures;
  final double opacity;
  final AppBarSearchBarSettings searchBar;
  final ValueChanged<bool> searchBarFocusThings;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: keys.searchBarKey,
      child: IgnorePointer(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                minSize: 0,
                padding: const EdgeInsets.only(left: 8),
                color: Colors.transparent,
                onPressed: () {
                  searchBarFocusThings(false);
                  focusNode.unfocus();
                  editingController.clear();
                },
                child: AnimatedOpacity(
                  duration: measures.scrollAnimationDuration,
                  opacity: _store.searchBarHasFocus.value ? 1 : 0,
                  child: Text(
                    searchBar.cancelButtonText,
                    style: context.appTheme.appBarTitleNActions
                        .copyWith(color: CupertinoTheme.of(context).primaryContrastingColor),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: CupertinoSearchTextField(
                    padding: const EdgeInsetsDirectional.fromSTEB(5.5, 0, 5.5, 0),
                    prefixIcon: Opacity(
                      opacity: _store.searchBarHasFocus.value ? 0 : opacity,
                      child: searchBar.prefixIcon,
                    ),
                    placeholder: searchBar.placeholderText,
                    placeholderStyle: context.appTheme.body.copyWith(
                      color: CupertinoColors.systemGrey.withOpacity(opacity),
                    ),
                    style: context.appTheme.body,
                    backgroundColor: context.appTheme.surface,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final AppBarActionSettings searchAction in searchBar.actions)
                      searchAction.behavior == AppBarActionSettingsBehavior.alwaysVisible
                          ? searchAction
                          : const SizedBox(),
                    AnimatedCrossFade(
                      firstChild: Center(
                        child: Row(
                          children: searchBar.actions
                              .where((e) => e.behavior == AppBarActionSettingsBehavior.visibleOnFocus)
                              .toList(),
                        ),
                      ),
                      secondChild: const SizedBox(),
                      crossFadeState:
                          _store.searchBarHasFocus.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: measures.standartAnimationDuration,
                    ),
                    AnimatedCrossFade(
                      firstChild: Center(
                        child: Row(
                          children: searchBar.actions
                              .where((e) => e.behavior == AppBarActionSettingsBehavior.visibleOnUnFocus)
                              .toList(),
                        ),
                      ),
                      secondChild: const SizedBox(),
                      crossFadeState:
                          _store.searchBarHasFocus.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: measures.standartAnimationDuration,
                    ),
                    AnimatedContainer(
                      duration: measures.standartAnimationDuration,
                      width: _store.searchBarHasFocus.value
                          ? defaultTextSize(
                              searchBar.cancelButtonText,
                              context.appTheme.appBarTitleNActions,
                            )
                          : 0,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
