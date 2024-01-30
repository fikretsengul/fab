import 'dart:async';

import 'package:deps/packages/easy_refresh.dart';
import 'package:deps/packages/extended_tabs.dart';
import 'package:deps/packages/nested_scroll_view_plus.dart';
import 'package:flutter/material.dart';

import '../../overridens/overriden_cupertino_scrollbar.dart';
import '../models/appbar_search_bar_settings.dart';
import '../utils/measures.dart';
import '../utils/store.dart';
import 'snap_scroll_listener.dart';

class Body extends StatelessWidget {
  const Body({
    required this.scrollController,
    required this.measures,
    required this.animationBehavior,
    required this.scrollBehavior,
    required this.refreshListenable,
    required this.isScrollable,
    required this.nestedScrollViewKey,
    required this.isCustomScrollView,
    required this.searchBar,
    this.child,
    this.children,
    this.tabController,
    this.otherScrollController,
    this.onRefresh,
    super.key,
  });

  final AppBarSearchBarSettings searchBar;
  final ScrollController? otherScrollController;
  final FutureOr<dynamic> Function()? onRefresh;
  final SearchBarAnimationBehavior animationBehavior;
  final TabController? tabController;
  final Widget? child;
  final List<Widget>? children;
  final bool isScrollable;
  final Measures measures;
  final IndicatorStateListenable refreshListenable;
  final SearchBarScrollBehavior scrollBehavior;
  final ScrollController scrollController;
  final GlobalKey<NestedScrollViewStatePlus> nestedScrollViewKey;
  final bool isCustomScrollView;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store.isInHero,
      builder: (_, isInHero, __) {
        return IgnorePointer(
          ignoring: isInHero,
          child: EasyRefresh.builder(
            onRefresh: onRefresh,
            header: ListenerHeader(
              processedDuration: Duration.zero,
              triggerOffset: 160,
              listenable: refreshListenable,
              clamping: false,
              hitOver: true,
              hapticFeedback: true,
            ),
            childBuilder: (_, physics) {
              return shouldWrapWithScrollbar(
                context,
                child: SnappingScrollListener(
                  scrollController: scrollController,
                  scrollBehavior: scrollBehavior,
                  collapsedHeight: measures.searchContainerHeight,
                  expandedHeight: measures.largeTitleContainerHeight,
                  child: NestedScrollViewPlus(
                    key: nestedScrollViewKey,
                    controller: scrollController,
                    physics: isScrollable ? physics : const NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (context, _) {
                      return [
                        ValueListenableBuilder(
                          valueListenable: _store.searchBarAnimationStatus,
                          builder: (_, __, ___) {
                            final topPadding = MediaQuery.paddingOf(context).top;
                            final minHeight = topPadding + measures.primaryToolbarHeight + measures.bottomToolbarHeight;
                            final maxHeight = _store.searchBarHasFocus.value
                                ? (searchBar.animationBehavior == SearchBarAnimationBehavior.top
                                    ? topPadding + measures.searchContainerHeight + measures.bottomToolbarHeight
                                    : topPadding + measures.appbarHeight)
                                : topPadding + measures.appbarHeight;

                            return SliverPersistentHeader(
                              pinned: true,
                              delegate: MyDelegate(
                                minHeight: isScrollable ? minHeight : maxHeight - 0.000001,
                                maxHeight: maxHeight,
                              ),
                            );
                          },
                        ),
                      ];
                    },
                    body: tabController != null
                        ? ExtendedTabBarView(
                            controller: tabController,
                            children: children!,
                          )
                        : isCustomScrollView
                            ? child!
                            : CustomScrollView(
                                physics: isScrollable
                                    ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
                                    : const NeverScrollableScrollPhysics(),
                                slivers: children!,
                              ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget shouldWrapWithScrollbar(BuildContext context, {required Widget child}) {
    if (tabController != null || isCustomScrollView) {
      return child;
    } else {
      return OverridenCupertinoScrollbar(
        controller: scrollController,
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + measures.appbarHeight),
        thumbVisibility: true,
        thicknessWhileDragging: 6,
        child: child,
      );
    }
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  double maxHeight;
  double minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(height: maxHeight);
  }
}
