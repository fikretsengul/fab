// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'gesture/drag_hold_controller.dart';
import 'gesture/gesture_mixin.dart';

/// The [SyncScrollController] to sync pixels for all of positions
class SyncScrollController extends ScrollController with SyncScrollControllerMixin {
  /// Creates a scroll controller that continually updates its
  /// [initialScrollOffset] to match the last scroll notification it received.
  SyncScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });
}

/// The mixin for [ScrollController] to sync pixels for all of positions
mixin SyncScrollControllerMixin on ScrollController implements GestureMixin {
  late final SyncScrollHandler _syncHandler = SyncScrollHandler();
  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    _syncHandler.attach(position);
  }

  @override
  void detach(ScrollPosition position) {
    _syncHandler.detach(position);
    super.detach(position);
  }

  @override
  void dispose() {
    _syncHandler.dispose();
    super.dispose();
  }

  @override
  void handleDragDown(DragDownDetails? details) {
    _syncHandler.handleDragDown(details);
  }

  @override
  void handleDragStart(DragStartDetails details) {
    _syncHandler.handleDragStart(details);
  }

  @override
  void handleDragUpdate(DragUpdateDetails details) {
    _syncHandler.handleDragUpdate(details);
  }

  @override
  void handleDragEnd(DragEndDetails details) {
    _syncHandler.handleDragEnd(details);
  }

  @override
  void handleDragCancel() {
    _syncHandler.handleDragCancel();
  }

  @override
  void forceCancel() {
    _syncHandler.forceCancel();
  }
}

class SyncScrollHandler implements GestureMixin {
  final Map<ScrollPosition, DragHoldController> _positionToListener = <ScrollPosition, DragHoldController>{};
  Map<ScrollPosition, DragHoldController> get positionToListener => _positionToListener;
  void attach(ScrollPosition position) {
    assert(!_positionToListener.containsKey(position));

    if (_positionToListener.isNotEmpty) {
      final otherScrollPosition = _positionToListener.keys.first;

      final pixels = otherScrollPosition.pixels > 102.0 ? 102.0 : otherScrollPosition.pixels;

      if (position.pixels != pixels) {
        position.correctPixels(pixels);
        position.applyViewportDimension(otherScrollPosition.viewportDimension);
        position.applyContentDimensions(
          otherScrollPosition.minScrollExtent,
          otherScrollPosition.maxScrollExtent,
        );
      }
      final activity = otherScrollPosition.activity;
      if (activity != null && activity.isScrolling && activity is BallisticScrollActivity) {
        position.activity?.delegate.goBallistic(activity.velocity);
      }
    }

    _positionToListener[position] = DragHoldController(position);
  }

  void detach(ScrollPosition position) {
    assert(_positionToListener.containsKey(position));
    _positionToListener[position]!.forceCancel();
    _positionToListener.remove(position);
  }

  void dispose() {
    forceCancel();
  }

  @override
  void handleDragDown(DragDownDetails? details) {
    for (final item in _positionToListener.values) {
      item.handleDragDown(details);
    }
  }

  @override
  void handleDragStart(DragStartDetails details) {
    for (final item in _positionToListener.values) {
      item.handleDragStart(details);
    }
  }

  @override
  void handleDragUpdate(DragUpdateDetails details) {
    for (final item in _positionToListener.values) {
      if (!item.hasDrag) {
        item.handleDragStart(
          DragStartDetails(
            globalPosition: details.globalPosition,
            localPosition: details.localPosition,
            sourceTimeStamp: details.sourceTimeStamp,
          ),
        );
      }
      item.handleDragUpdate(details);
    }
  }

  @override
  void handleDragEnd(DragEndDetails details) {
    for (final item in _positionToListener.values) {
      item.handleDragEnd(details);
    }
  }

  @override
  void handleDragCancel() {
    for (final item in _positionToListener.values) {
      item.handleDragCancel();
    }
  }

  @override
  void forceCancel() {
    for (final item in _positionToListener.values) {
      item.forceCancel();
    }
  }
}
