import 'package:flutter/material.dart';

class CustomScrollController extends ScrollController {
  CustomScrollController({
    required this.isActive,
    required this.parent,
    String debugLabel = 'CustomScrollController',
  }) : super(
          debugLabel: parent.debugLabel == null ? null : '${parent.debugLabel}/$debugLabel',
          initialScrollOffset: parent.initialScrollOffset,
          keepScrollOffset: parent.keepScrollOffset,
        );

  bool isActive;
  final ScrollController parent;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    debugPrint('$debugLabel-createScrollPosition: $isActive');

    return parent.createScrollPosition(physics, context, oldPosition);
  }

  @override
  void attach(ScrollPosition position) {
    debugPrint('$debugLabel-attach: $isActive');

    super.attach(position);
    if (isActive && !parent.positions.contains(position)) {
      parent.attach(position);
    }
  }

  @override
  void detach(ScrollPosition position) {
    debugPrint('$debugLabel-detach: $isActive');

    if (parent.positions.contains(position)) {
      parent.detach(position);
    }

    super.detach(position);
  }

  void forceDetach() {
    debugPrint('$debugLabel-forceDetach: $isActive');

    for (final position in positions) {
      if (parent.positions.contains(position)) {
        parent.detach(position);
      }
    }
  }

  void forceAttach() {
    debugPrint('$debugLabel-forceAttach: $isActive');

    for (final position in positions) {
      if (!parent.positions.contains(position)) {
        parent.attach(position);
      }
    }
  }

  @override
  void dispose() {
    debugPrint('$debugLabel-dispose: $isActive');

    forceDetach();
    super.dispose();
  }
}
