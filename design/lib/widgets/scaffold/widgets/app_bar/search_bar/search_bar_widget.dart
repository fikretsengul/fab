import 'package:flutter/cupertino.dart';

import '../../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../../models/fab_appbar_search_bar_settings.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';
import 'widgets/dynamic_search_bar_widget.dart';
import 'widgets/static_search_bar_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    required this.measures,
    required this.searchBar,
    required this.editingController,
    required this.focusNode,
    required this.keys,
    super.key,
  });

  final Measures measures;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final NavigationBarStaticComponentsKeys keys;
  final FabAppBarSearchBarSettings searchBar;

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
      Future.delayed(measures.getSlowAnimationDuration, () {
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
        height: _store.getSearchBarHeight.value,
        child: Padding(
          padding: EdgeInsets.only(bottom: measures.getSearchBarBottomPadding),
          child: Stack(
            children: [
              StaticSearchBarWidget(
                measures: measures,
                keys: keys,
                searchBar: searchBar,
                focusNode: focusNode,
                editingController: editingController,
                searchBarFocusThings: searchBarFocusThings,
              ),
              DynamicSearchBarWidget(
                measures: measures,
                searchBar: searchBar,
                editingController: editingController,
                focusNode: focusNode,
                searchBarFocusThings: searchBarFocusThings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
