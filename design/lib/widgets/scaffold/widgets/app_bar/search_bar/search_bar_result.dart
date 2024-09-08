import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:flutter/material.dart';

import '../../../utils/measures.dart';
import '../../../utils/store.dart';

class SearchBarResult extends StatelessWidget {
  const SearchBarResult({
    required this.measures,
    required this.searchBar,
    super.key,
  });

  final Measures measures;
  final FabAppBarSearchBarSettings searchBar;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store.searchBarResultVisible,
      builder: (context, searchBarResultVisible, _) {
        return IgnorePointer(
          ignoring: !searchBarResultVisible,
          child: AnimatedOpacity(
            duration: measures.getSlowAnimationDuration,
            opacity: searchBarResultVisible ? 1 : 0,
            child: Container(
              width: $.context.mqSize.width,
              height: $.context.mqSize.height,
              color: context.fabTheme.backgroundColor,
              padding: EdgeInsets.only(
                top: measures.getSafeZoneTopPadding + measures.getSearchBarHeight + measures.searchToolbarHeight,
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
