import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: CupertinoSearchTextField(
                padding: const EdgeInsetsDirectional.fromSTEB(5.5, 0, 5.5, 0),
                prefixIcon: Opacity(
                  opacity: _store.searchBarHasFocus.value ? 0 : opacity,
                  child: searchBar.prefixIcon,
                ),
                placeholder: _store.searchBarHasFocus.value ? '' : searchBar.placeholderText,
                placeholderStyle: searchBar.placeholderTextStyle.copyWith(
                  color: searchBar.placeholderTextStyle.color!.withOpacity(opacity),
                ),
                style: searchBar.textStyle.copyWith(
                  color: searchBar.textStyle.color ?? CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
                backgroundColor: searchBar.backgroundColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final AppBarActionSettings searchAction in searchBar.actions)
                  searchAction.behavior == AppBarActionSettingsBehavior.alwaysVisible ? searchAction : const SizedBox(),
                AnimatedCrossFade(
                  firstChild: Center(
                    child: Row(
                      children: searchBar.actions
                          .where((e) => e.behavior == AppBarActionSettingsBehavior.visibleOnFocus)
                          .toList(),
                    ),
                  ),
                  secondChild: const SizedBox(),
                  crossFadeState: _store.searchBarHasFocus.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                  crossFadeState: _store.searchBarHasFocus.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: measures.standartAnimationDuration,
                ),
                Center(
                  child: CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    color: Colors.transparent,
                    onPressed: () {
                      searchBarFocusThings(false);
                      focusNode.unfocus();
                      editingController.clear();
                    },
                    child: AnimatedContainer(
                      duration: measures.standartAnimationDuration,
                      width: _store.searchBarHasFocus.value
                          ? textSize(searchBar.cancelButtonText, searchBar.cancelTextStyle)
                          : 0,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          searchBar.cancelButtonText,
                          style: searchBar.cancelTextStyle,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
