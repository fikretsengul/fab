// ignore_for_file: avoid_returning_widgets, max_lines_for_file

import 'dart:async';

import 'package:deps/features/features.dart';
import 'package:deps/packages/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/fab_theme.dart';
import 'models/fab_appbar_settings.dart';
import 'utils/measures.dart';
import 'utils/store.dart';
import 'widgets/app_bar/animated_app_bar_builder.dart';
import 'widgets/app_bar/search_bar/search_bar_result.dart';
import 'widgets/body.dart';
import 'widgets/linked_scroll_controller.dart';
import 'widgets/refresher.dart';

class FabScaffold extends StatefulWidget {
  FabScaffold({
    required this.children,
    required this.appBarSettings,
    this.tabController,
    super.key,
    this.onRefreshes = const [],
    this.shouldTransiteBetweenRoutes = true,
  }) : measures = Measures(
          searchBarHeight: appBarSettings.searchBar.height,
          largeTitleHeight: appBarSettings.largeTitle.height,
          topToolbarHeight: appBarSettings.height,
          bottomToolbarHeight: appBarSettings.toolbar.height,
        );

  final List<FutureOr<dynamic> Function()?> onRefreshes;
  final FabAppBarSettings appBarSettings;
  final List<Widget> children;
  final Measures measures;
  final bool shouldTransiteBetweenRoutes;
  final TabController? tabController;

  @override
  State<FabScaffold> createState() => _SuperScaffoldState();
}

class _SuperScaffoldState extends State<FabScaffold> {
  late final ValueNotifier<int> _activeIndex;
  late final IndicatorStateListenable _refreshListenable;
  late final List<ScrollController> _scrollControllers;
  late final LinkedScrollControllerGroup _syncScrollController;

  @override
  void didChangeDependencies() {
    _store.calculate(0, measures: widget.measures, settings: widget.appBarSettings);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _activeIndex.dispose();
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _refreshListenable = IndicatorStateListenable();
    _syncScrollController = LinkedScrollControllerGroup();
    _activeIndex = ValueNotifier(0);
    _scrollControllers = List.generate(
      widget.children.length,
      (_) => _syncScrollController.addAndGet(),
    );

    widget.tabController?.animation?.addListener(() {
      final newIndex = widget.tabController?.animation!.value.round();

      if (_activeIndex.value != newIndex) {
        _activeIndex.value = widget.tabController?.animation?.value.round() ?? 0;

/*         _store.isSearchBarEnabled.value = newIndex == 0;s
        final offset = newIndex == 1 ? _syncScrollController.offset + 50 : _syncScrollController.offset - 50;
        _syncScrollController.animateTo(offset, curve: Curves.linear, duration: const Duration(milliseconds: 250)); */
      }
    });
  }

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // TODO: bakılacak
      canPop: !_store.searchBarHasFocus.value,
      child: Scaffold(
        backgroundColor: context.fabTheme.backgroundColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Body(
              measures: widget.measures,
              scrollControllers: _scrollControllers,
              searchBar: widget.appBarSettings.searchBar,
              refreshListenable: _refreshListenable,
              tabController: widget.tabController,
              onRefreshes: widget.onRefreshes,
              children: widget.children,
            ),
            SearchBarResult(
              measures: widget.measures,
              searchBar: widget.appBarSettings.searchBar,
            ),
            AnimatedAppBarBuilder(
              syncScrollController: _syncScrollController,
              appBarSettings: widget.appBarSettings,
              measures: widget.measures,
              shouldTransiteBetweenRoutes: widget.shouldTransiteBetweenRoutes,
            ),
            ValueListenableBuilder(
              valueListenable: _activeIndex,
              builder: (_, index, __) {
                final hasRefresher = widget.onRefreshes.elementAtOrNull(index) != null;

                if (hasRefresher) {
                  return Refresher(refreshListenable: _refreshListenable);
                }

                return const Nil();
              },
            ),
          ],
        ),
      ),
    );
  }
}
