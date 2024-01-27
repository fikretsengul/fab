import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/appbar_search_bar_settings.dart';
import '../../../utils/measures.dart';
import '../../../utils/store.dart';

class SearchBarResult extends StatelessWidget {
  const SearchBarResult({
    required this.measures,
    required this.searchBar,
    super.key,
  });

  final Measures measures;
  final AppBarSearchBarSettings searchBar;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.sizeOf(context);

    return ValueListenableBuilder(
      valueListenable: _store.searchBarResultVisible,
      builder: (context, searchBarResultVisible, _) {
        return IgnorePointer(
          ignoring: !searchBarResultVisible,
          child: AnimatedOpacity(
            duration: measures.searchBarAnimationDuration,
            opacity: searchBarResultVisible ? 1 : 0,
            child: Container(
              width: sizes.width,
              height: sizes.height,
              color: CupertinoDynamicColor.maybeResolve(
                    searchBar.resultColor,
                    context,
                  ) ??
                  CupertinoTheme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + measures.searchContainerHeight + measures.bottomToolbarHeight,
              ),
              child: Stack(
                children: [
                  const Text(
                    '.',
                    style: TextStyle(color: Colors.transparent),
                  ),
                  searchBar.searchResult,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
