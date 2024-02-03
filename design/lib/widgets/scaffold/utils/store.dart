import 'package:flutter/cupertino.dart';

class Store {
  Store._init();

  factory Store.instance() {
    _instance ??= Store._init();

    return _instance!;
  }

  final ValueNotifier<bool> isContentScrollable = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isInHero = ValueNotifier<bool>(false);
  final ValueNotifier<double> scrollOffset = ValueNotifier<double>(0);
  final ValueNotifier<SearchBarAnimationStatus> searchBarAnimationStatus =
      ValueNotifier(SearchBarAnimationStatus.paused);

  final ValueNotifier<bool> searchBarHasFocus = ValueNotifier(false);
  final ValueNotifier<bool> searchBarResultVisible = ValueNotifier(false);

  static Store? _instance;
}

enum SearchBarAnimationStatus { started, onGoing, paused }
