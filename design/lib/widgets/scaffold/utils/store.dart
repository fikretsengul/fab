// ignore_for_file: dead_code

import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../models/fab_appbar_search_bar_settings.dart';
import '../models/fab_appbar_settings.dart';
import 'measures.dart';

enum SearchBarAnimationStatus { started, onGoing, paused }

class Store {
  Store._init();

  factory Store.instance() {
    _instance ??= Store._init();

    return _instance!;
  }

  void calculate(
    double offset, {
    required Measures measures,
    required FabAppBarSettings settings,
  }) {
    height.value = settings.searchBar.scrollBehavior == SearchBarScrollBehavior.floated
        ? clampDouble(
            measures.getAppBarHeightWSafeZone - offset,
            measures.getTopToolbarHeightWSafeZone + settings.toolbar.height,
            3000,
          )
        : clampDouble(
            measures.getAppBarHeightWSafeZone - offset,
            measures.getAppBarHeightWSafeZone - measures.largeTitleHeight,
            3000,
          );

    largeTitleHeight.value = settings.searchBar.scrollBehavior == SearchBarScrollBehavior.floated
        ? (offset > measures.getSearchBarHeight
            ? clampDouble(
                measures.largeTitleHeight - (offset - measures.getSearchBarHeight),
                0,
                measures.largeTitleHeight,
              )
            : measures.largeTitleHeight)
        : clampDouble(measures.largeTitleHeight - offset, 0, measures.largeTitleHeight);

    getSearchBarHeight.value = settings.searchBar.scrollBehavior == SearchBarScrollBehavior.floated
        ? (searchBarHasFocus.value
            ? measures.getSearchBarHeight
            : clampDouble(measures.getSearchBarHeight - offset, 0, measures.getSearchBarHeight))
        : measures.getSearchBarHeight;

    opacity.value = settings.searchBar.scrollBehavior == SearchBarScrollBehavior.floated
        ? (searchBarHasFocus.value ? 1.0 : clampDouble(1 - offset / 10.0, 0, 1))
        : 1.0;

    largeTitleOpacity.value = settings.searchBar.scrollBehavior == SearchBarScrollBehavior.floated
        ? (offset >= (measures.getAppBarHeightWoTopToolbar - settings.toolbar.height - 20)
            ? 1.0
            : (measures.largeTitleHeight > 0.0 ? 0.0 : 1.0))
        : (offset >= (measures.largeTitleHeight - 20) ? 1.0 : (measures.largeTitleHeight > 0.0 ? 0.0 : 1.0));

    largeTitleScale.value = offset < 0 ? clampDouble(1 - offset / 1500, 1, 1.12) : 1.0;

    if (settings.searchBar.animationBehavior == SearchBarAnimationBehavior.steady && searchBarHasFocus.value) {
      height.value = measures.getAppBarHeightWSafeZone;
      largeTitleHeight.value = measures.largeTitleHeight;
      largeTitleScale.value = 1;
      largeTitleOpacity.value = 0;
    }

    if (settings.alwaysShowTitle) {
      largeTitleOpacity.value = 1;
    }

    if (!settings.searchBar.enabled) {
      opacity.value = 0;
    }
  }

  final ValueNotifier<double> height = ValueNotifier<double>(0);
  final ValueNotifier<double> opacity = ValueNotifier<double>(0);
  final ValueNotifier<double> largeTitleHeight = ValueNotifier<double>(0);
  final ValueNotifier<double> largeTitleOpacity = ValueNotifier<double>(0);
  final ValueNotifier<double> largeTitleScale = ValueNotifier<double>(0);
  final ValueNotifier<double> getSearchBarHeight = ValueNotifier<double>(0);
  final ValueNotifier<SearchBarAnimationStatus> searchBarAnimationStatus =
      ValueNotifier(SearchBarAnimationStatus.paused);
  final ValueNotifier<bool> isInHero = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isSearchBarEnabled = ValueNotifier(true);
  final ValueNotifier<bool> searchBarHasFocus = ValueNotifier(false);
  final ValueNotifier<bool> searchBarResultVisible = ValueNotifier(false);

  static Store? _instance;
}
