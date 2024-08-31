import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';

import '../../_core/overridens/overriden_transitionable_navigation_bar.dart';

class Measures {
  Measures({
    required this.searchBarHeight,
    required this.largeTitleHeight,
    required this.topToolbarHeight,
    required this.bottomToolbarHeight,
  });

  factory Measures.instance() {
    _instance ??= Measures(
      searchBarHeight: 35,
      largeTitleHeight: 50,
      topToolbarHeight: kMinInteractiveDimensionCupertino,
      bottomToolbarHeight: 40,
    );

    return _instance!;
  }

  static Measures? _instance;

  double largeTitleHeight;
  double topToolbarHeight;
  double searchBarHeight;
  double bottomToolbarHeight;

  static const HeroTag defaultHeroTag = HeroTag(null);

  Duration get getLargeTitleOpacityAnimDur => const Duration(milliseconds: 100);
  Duration get getStandartAnimDur => const Duration(milliseconds: 200);
  Duration get getScrollAnimDur => const Duration(milliseconds: 300);
  Duration get getSearchBarFocusAnimDur => const Duration(milliseconds: 250);

  double get getSafeZoneTopPadding => $.context.mqPadding.top;
  double get getTopToolbarHeightWSafeZone => getSafeZoneTopPadding + topToolbarHeight;
  double get getSearchBarBottomPadding => 8;
  double get getSearchBarHeight => searchBarHeight == 0 ? 0 : searchBarHeight + getSearchBarBottomPadding;
  double get getAppBarHeightWSafeZone =>
      getTopToolbarHeightWSafeZone + largeTitleHeight + getSearchBarHeight + bottomToolbarHeight;
  double get getAppBarFocusedHeightWSafeZone => getSafeZoneTopPadding + getSearchBarHeight + bottomToolbarHeight;
  double get getAppBarHeightWoTopToolbar => largeTitleHeight + getSearchBarHeight + bottomToolbarHeight;
}
