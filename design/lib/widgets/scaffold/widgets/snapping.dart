/* import 'package:deps/packages/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'snap.dart';

typedef CollapsingStateCallback = void Function(
  bool isCollapsed,
  double scrollingOffset,
  double maxExtent,
);

class Snapping extends HookWidget {
  const Snapping({
    required this.child,
    required this.collapsedBarHeight,
    super.key,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.expandedContentHeight,
    this.scrollController,
    this.scrollBehavior,
  });
  final ScrollController? scrollController;

  final Widget child;

  final double? expandedContentHeight;

  final double collapsedBarHeight;

  final ScrollBehavior? scrollBehavior;

  final Duration? animationDuration;

  final Curve? animationCurve;

  @override
  Widget build(BuildContext context) {
    final isCollapsedValueNotifier = useState(false);
    final defaultExpandedContentHeight = expandedContentHeight ?? MediaQuery.sizeOf(context).height / 2;

    final controller = scrollController ?? useScrollController();
    final snappingScrollNotificationHandler = SnappingScrollNotificationHandler.withHapticFeedback(
      expandedBarHeight: defaultExpandedContentHeight,
      collapsedBarHeight: collapsedBarHeight,
    );

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => snappingScrollNotificationHandler.handleScrollNotification(
        notification: notification,
        isCollapsedValueNotifier: isCollapsedValueNotifier,
        scrollController: controller,
      ),
      child: child,
    );
  }
}
 */