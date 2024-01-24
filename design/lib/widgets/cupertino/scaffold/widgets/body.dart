import 'dart:async';

import 'package:deps/packages/easy_refresh.dart';
import 'package:deps/packages/nested_scroll_view_plus.dart';
import 'package:deps/packages/snap_scroll_physics.dart';
import 'package:flutter/material.dart';

import '../models/appbar_search_bar_settings.dart';
import '../utils/measures.dart';
import '../utils/store.dart';

class Body extends StatelessWidget {
  const Body({
    required this.scrollController,
    required this.body,
    required this.topPadding,
    required this.measures,
    required this.animationBehavior,
    required this.scrollBehavior,
    required this.refreshListenable,
    required this.isScrollEnabled,
    required this.nestedScrollViewKey,
    required this.margin,
    this.onRefresh,
    super.key,
  });

  final FutureOr<dynamic> Function()? onRefresh;
  final SearchBarAnimationBehavior animationBehavior;
  final Widget body;
  final ValueNotifier<bool> isScrollEnabled;
  final EdgeInsets margin;
  final Measures measures;
  final GlobalKey<NestedScrollViewStatePlus> nestedScrollViewKey;
  final IndicatorStateListenable refreshListenable;
  final SearchBarScrollBehavior scrollBehavior;
  final ScrollController scrollController;
  final double topPadding;

  Store get _store => Store.instance();

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
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
        return ValueListenableBuilder<bool>(
          valueListenable: isScrollEnabled,
          builder: (_, isContentScrollable, __) {
            return NestedScrollViewPlus(
              key: nestedScrollViewKey,
              controller: scrollController,
              physics: SnapScrollPhysics(
                parent: isContentScrollable ? physics : const NeverScrollableScrollPhysics(),
                snaps: [
                  if (scrollBehavior == SearchBarScrollBehavior.floated) ...{
                    Snap.avoidZone(0, measures.searchContainerHeight),
                  },
                  if (scrollBehavior == SearchBarScrollBehavior.floated) ...{
                    Snap.avoidZone(
                      measures.searchContainerHeight,
                      measures.largeTitleContainerHeight + measures.searchContainerHeight,
                    ),
                  },
                  if (scrollBehavior == SearchBarScrollBehavior.pinned) ...{
                    Snap.avoidZone(0, measures.largeTitleContainerHeight),
                  },
                ],
              ),
              headerSliverBuilder: (_, __) {
                return [
                  ValueListenableBuilder(
                    valueListenable: _store.searchBarAnimationStatus,
                    builder: (_, __, ___) {
                      final height = topPadding + measures.appbarHeight;

                      return OverlapAbsorberPlus(
                        sliver: SliverPersistentHeader(
                          pinned: true,
                          delegate: MyDelegate(
                            minHeight: isContentScrollable ? 0 : height - 0.000001,
                            maxHeight: height,
                          ),
                        ),
                      );
                    },
                  ),
                ];
              },
              body: ValueListenableBuilder(
                valueListenable: _store.isInHero,
                builder: (_, isInHero, __) {
                  return IgnorePointer(
                    ignoring: isInHero,
                    child: Padding(
                      padding: margin,
                      child: body,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
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
