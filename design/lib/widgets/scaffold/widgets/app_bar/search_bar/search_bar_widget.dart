import 'package:flutter/cupertino.dart';

import '../../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../../models/fab_appbar_search_bar_settings.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';
import 'widgets/dynamic_search_bar_widget.dart';
import 'widgets/static_search_bar_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    required this.searchBar,
    required this.measures,
    required this.searchBarHeight,
    required this.opacity,
    required this.editingController,
    required this.focusNode,
    required this.keys,
    super.key,
  });

  final TextEditingController editingController;
  final FocusNode focusNode;
  final NavigationBarStaticComponentsKeys keys;
  final Measures measures;
  final double opacity;
  final FabAppBarSearchBarSettings searchBar;
  final double searchBarHeight;

  void searchBarFocusThings(bool hasFocus) {
    _store.searchBarHasFocus.value = hasFocus;

    _store.searchBarAnimationStatus.value =
        hasFocus ? SearchBarAnimationStatus.started : SearchBarAnimationStatus.onGoing;
    if (hasFocus) {
      if (searchBar.resultBehavior == SearchBarResultBehavior.visibleOnFocus) {
        _store.searchBarResultVisible.value = true;
      }
    } else {
      _store.searchBarResultVisible.value = false;
    }
    if (!hasFocus) {
      Future.delayed(measures.searchBarAnimationDuration, () {
        _store.searchBarAnimationStatus.value = SearchBarAnimationStatus.paused;
      });
    }
    searchBar.onFocused?.call(hasFocus);
  }

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: searchBar.padding,
      child: SizedBox(
        height: searchBarHeight,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: measures.searchBarBottomPadding,
          ),
          child: Stack(
            children: [
              StaticSearchBarWidget(
                keys: keys,
                searchBar: searchBar,
                measures: measures,
                opacity: opacity,
                focusNode: focusNode,
                editingController: editingController,
                searchBarFocusThings: searchBarFocusThings,
              ),
              DynamicSearchBarWidget(
                searchBar: searchBar,
                editingController: editingController,
                focusNode: focusNode,
                animationDuration: measures.standartAnimationDuration,
                searchBarHasFocus: _store.searchBarHasFocus.value,
                searchBarFocusThings: searchBarFocusThings,
                opacity: opacity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
