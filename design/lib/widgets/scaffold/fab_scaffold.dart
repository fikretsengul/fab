// ignore_for_file: avoid_returning_widgets, max_lines_for_file

import 'dart:async';

import 'package:deps/packages/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/fab_theme.dart';
import '../_core/overridens/overriden_transitionable_navigation_bar.dart';
import 'models/fab_appbar_settings.dart';
import 'utils/helpers.dart';
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
          searchBarHeight: appBarSettings.searchBar!.height,
          largeTitleHeight: appBarSettings.largeTitle!.height,
          topToolbarHeight: appBarSettings.height,
          bottomToolbarHeight: appBarSettings.toolbar!.height,
          searchToolbarHeight: appBarSettings.searchBar!.toolbar!.height,
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
  late final NavigationBarStaticComponentsKeys _keys;
  late final ValueNotifier<int> _activeIndex;
  late final IndicatorStateListenable _refreshListenable;
  late final List<ScrollController> _scrollControllers;
  late final LinkedScrollControllerGroup _syncScrollController;

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
    _keys = NavigationBarStaticComponentsKeys();
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
      }
    });
  }

/*   @override
  void didChangeDependencies() {
    _store.calculate(_syncScrollController.offset, measures: widget.measures, settings: widget.appBarSettings);
    super.didChangeDependencies();
  } */

  Store get _store => Store.instance();

  NavigationBarStaticComponents _configureComponents() {
    final smallTitle = widget.appBarSettings.title is Text
        ? Text(
            '${(widget.appBarSettings.title! as Text).data}',
            style: defaultTitleTextStyle(context, widget.appBarSettings),
          )
        : widget.appBarSettings.title;

    return NavigationBarStaticComponents(
      keys: _keys,
      route: ModalRoute.of(context),
      userLeading: widget.appBarSettings.leading,
      automaticallyImplyLeading: widget.appBarSettings.automaticallyImplyLeading,
      automaticallyImplyTitle: true,
      previousPageTitle: widget.appBarSettings.previousPageTitle,
      userMiddle: smallTitle,
      userTrailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [...widget.appBarSettings.actions],
        ),
      ),
      largeTitleActions: Row(
        children: [
          ...?widget.appBarSettings.largeTitle!.actions,
        ],
      ),
      userLargeTitle: Text(
        widget.appBarSettings.largeTitle!.text,
        style: context.fabTheme.appBarLargeTitleStyle.copyWith(inherit: false),
        overflow: TextOverflow.ellipsis,
      ),
      appbarBottom: widget.appBarSettings.toolbar!.child,
      padding: null,
      large: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final components = _configureComponents();

    print('AMK');

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
              searchBar: widget.appBarSettings.searchBar!,
              refreshListenable: _refreshListenable,
              tabController: widget.tabController,
              onRefreshes: widget.onRefreshes,
              children: widget.children,
            ),
            SearchBarResult(
              measures: widget.measures,
              searchBar: widget.appBarSettings.searchBar!,
            ),
            AnimatedAppBarBuilder(
              keys: _keys,
              components: components,
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

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
