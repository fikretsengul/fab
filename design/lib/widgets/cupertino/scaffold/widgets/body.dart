import 'dart:async';

import 'package:deps/packages/easy_refresh.dart';
import 'package:deps/packages/snap_scroll_physics.dart';
import 'package:flutter/cupertino.dart';

import '../../../../design.dart';
import '../../overridens/overriden_cupertino_scrollbar.dart';
import '../utils/measures.dart';
import '../utils/store.dart';

class Body extends StatelessWidget {
  const Body({
    required this.scrollController,
    required this.body,
    required this.measures,
    required this.animationBehavior,
    required this.scrollBehavior,
    required this.refreshListenable,
    required this.isScrollable,
    this.onRefresh,
    super.key,
  });

  final FutureOr<dynamic> Function()? onRefresh;
  final SearchBarAnimationBehavior animationBehavior;
  final Widget body;
  final bool isScrollable;
  final Measures measures;
  final IndicatorStateListenable refreshListenable;
  final SearchBarScrollBehavior scrollBehavior;
  final ScrollController scrollController;

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
              return OverridenCupertinoScrollbar(
                controller: scrollController,
                padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + measures.appbarHeight + 8),
                thumbVisibility: true,
                thicknessWhileDragging: 6,
                child: CustomScrollView(
                  controller: scrollController,
                  physics: SnapScrollPhysics(
                    parent: isScrollable ? physics : const NeverScrollableScrollPhysics(),
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
                  slivers: [
                    ValueListenableBuilder(
                      valueListenable: _store.searchBarAnimationStatus,
                      builder: (_, __, ___) {
                        final height = MediaQuery.paddingOf(context).top + measures.appbarHeight;

                        return SliverPersistentHeader(
                          pinned: true,
                          delegate: MyDelegate(
                            minHeight: isScrollable ? 0 : height - 0.000001,
                            maxHeight: height,
                          ),
                        );
                      },
                    ),
                    body,
                  ],
                ),
              );
            },
          ),
        );
      },
      /*               body: ValueListenableBuilder(
                    valueListenable: _store.isInHero,
                    builder: (_, isInHero, __) {
                      return IgnorePointer(
                        ignoring: isInHero,
                        child: hasScrollView
                            ? body
                            : CustomScrollView(
                                physics: isContentScrollable
                                    ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
                                    : const NeverScrollableScrollPhysics(),
                                slivers: [
                                  const OverlapInjectorPlus(),
                                  SliverToBoxAdapter(child: body),
                                ],
                              ),
                      );
                    },
                  ),
                );
              },*/
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
