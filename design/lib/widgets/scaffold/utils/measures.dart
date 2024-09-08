import 'package:deps/features/features.dart';

import '../../_core/overridens/overriden_transitionable_navigation_bar.dart';

class Measures {
  Measures({
    required this.searchBarHeight,
    required this.largeTitleHeight,
    required this.topToolbarHeight,
    double? bottomToolbarHeight,
    double? searchToolbarHeight,
  })  : bottomToolbarHeight = bottomToolbarHeight ?? 36,
        searchToolbarHeight = searchToolbarHeight ?? 36;

  double largeTitleHeight;
  double topToolbarHeight;
  double searchBarHeight;
  double bottomToolbarHeight;
  double searchToolbarHeight;

  static const HeroTag defaultHeroTag = HeroTag(null);

  Duration get getLargeTitleOpacityAnimDur => const Duration(milliseconds: 100);
  Duration get getStandartAnimDur => const Duration(milliseconds: 200);
  Duration get getScrollAnimDur => const Duration(milliseconds: 300);
  Duration get getSearchBarFocusAnimDur => const Duration(milliseconds: 2500);

  double get getTitleFadeOutPadding => 16;
  double get getSafeZoneTopPadding => $.context.mqPadding.top;
  double get getTopToolbarHeightWSafeZone => getSafeZoneTopPadding + topToolbarHeight;
  double get getSearchBarBottomPadding => 8;
  double get getSearchBarHeight => searchBarHeight == 0 ? 0 : searchBarHeight + getSearchBarBottomPadding;
  double get getAppBarHeightWSafeZone =>
      getTopToolbarHeightWSafeZone + largeTitleHeight + getSearchBarHeight + bottomToolbarHeight;
  double get getAppBarFocusedHeightWSafeZone => getSafeZoneTopPadding + getSearchBarHeight + searchToolbarHeight;
  double get getAppBarHeightWoTopToolbar => largeTitleHeight + getSearchBarHeight + bottomToolbarHeight;
}
