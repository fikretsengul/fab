import 'package:flutter/cupertino.dart';

import '../widgets/transitionable_navigation_bar.dart';

class Measures {
  Measures({
    this.searchTextFieldHeight = 35.0,
    this.largeTitleContainerHeight = 52.0,
    this.primaryToolbarHeight = kMinInteractiveDimensionCupertino,
    this.bottomToolbarHeight = 40.0,
    this.searchBarAnimationDurationx = const Duration(milliseconds: 250),
  });

  factory Measures.instance() {
    _instance ??= Measures();

    return _instance!;
  }

  static const HeroTag defaultHeroTag = HeroTag(null);

  double bottomToolbarHeight;
  double largeTitleContainerHeight;
  double primaryToolbarHeight;
  Duration searchBarAnimationDurationx;
  double searchTextFieldHeight;

  static Measures? _instance;

  Duration get titleOpacityAnimationDuration => const Duration(milliseconds: 100);

  Duration get standartAnimationDuration => const Duration(milliseconds: 200);

  Duration get scrollAnimationDuration => const Duration(milliseconds: 300);

  Duration get searchBarAnimationDuration => searchBarAnimationDurationx;

  double get appbarHeight =>
      primaryToolbarHeight + searchContainerHeight + largeTitleContainerHeight + bottomToolbarHeight;

  double get appbarHeightExceptPrimaryToolbar =>
      searchContainerHeight + largeTitleContainerHeight + bottomToolbarHeight;

  double get searchBarBottomPadding => 14;

  double get searchContainerHeight => searchTextFieldHeight == 0 ? 0 : searchTextFieldHeight + searchBarBottomPadding;
}
