import 'package:flutter/widgets.dart';

import 'lint_state.dart';
import 'sync_scroll_controller.dart';

/// The [LinkScrollController] to sync pixels for all of positions
class LinkScrollController extends ScrollController with LinkScrollControllerMixin {
  /// Creates a scroll controller that continually updates its
  /// [initialScrollOffset] to match the last scroll notification it received.
  LinkScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
    this.parent,
  });

  /// The Outer SyncScrollController, for example [ExtendedTabBarView] or [ExtendedPageView]
  /// It make better experience when scroll on horizontal direction
  @override
  final LinkScrollControllerMixin? parent;
}

/// The [LinkPageController] to scroll Pages(PageView or TabBarView) when [FlexGrid] is reach the horizontal boundary
class LinkPageController extends PageController with LinkScrollControllerMixin {
  /// Creates a page controller.
  ///
  /// The [initialPage], [keepPage], and [viewportFraction] arguments must not be null.
  LinkPageController({
    super.initialPage,
    super.keepPage,
    super.viewportFraction,
    this.parent,
  });

  /// The Outer SyncScrollController, for example [ExtendedTabBarView] or [ExtendedPageView]
  /// It make better experience when scroll on horizontal direction
  @override
  final LinkScrollControllerMixin? parent;
}

mixin LinkScrollControllerMixin on ScrollController
// TODO(zmtzawqlp): i want something like mixin LinkScrollControllerMixin with SyncScrollControllerMixin
// so don't need to override everything in SyncScrollControllerMixin
// https://github.com/dart-lang/language/issues/540
// https://github.com/dart-lang/sdk/issues/50167
    implements
        SyncScrollControllerMixin {
  late final SyncScrollHandler _syncHandler = SyncScrollHandler();
  // The parent from user
  LinkScrollControllerMixin? get parent;
  // The parent from link
  LinkScrollControllerMixin? _parent;

  // The actual used parent
  LinkScrollControllerMixin? get _internalParent => parent ?? _parent;

  // The current actived controller
  LinkScrollControllerMixin? _activedLinkParent;

  bool get parentIsNotNull => _internalParent != null;

  bool get isSelf => _activedLinkParent == null;

  void linkParent<S extends StatefulWidget, T extends LinkScrollState<S>>(BuildContext context) {
    _parent = context.findAncestorStateOfType<T>()?.linkScrollController;
  }

  void unlinkParent() {
    _parent = null;
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
    if (_activedLinkParent != null && _activedLinkParent!.hasDrag) {
      _activedLinkParent!.handleDragUpdate(details);
    } else {
      _syncHandler.handleDragUpdate(details);
    }
  }

  @override
  void handleDragEnd(DragEndDetails details) {
    _activedLinkParent?.handleDragEnd(details);
    _syncHandler.handleDragEnd(details);
  }

  @override
  void handleDragCancel() {
    _activedLinkParent?.handleDragCancel();
    _activedLinkParent = null;
    _syncHandler.handleDragCancel();
  }

  @override
  void forceCancel() {
    _activedLinkParent?.forceCancel();
    _activedLinkParent = null;
    _syncHandler.forceCancel();
  }

  double get extentAfter => _activedLinkParent != null ? _activedLinkParent!.extentAfter : _extentAfter;

  double get extentBefore => _activedLinkParent != null ? _activedLinkParent!.extentBefore : _extentBefore;

  double get _extentAfter =>
      _syncHandler.positionToListener.keys.isEmpty ? 0 : _syncHandler.positionToListener.keys.first.extentAfter;

  double get _extentBefore =>
      _syncHandler.positionToListener.keys.isEmpty ? 0 : _syncHandler.positionToListener.keys.first.extentBefore;

  bool get hasDrag => _activedLinkParent != null ? _activedLinkParent!.hasDrag : _hasDrag;
  bool get hasHold => _activedLinkParent != null ? _activedLinkParent!.hasHold : _hasHold;

  bool get _hasDrag => _syncHandler.positionToListener.values.any((element) => element.hasDrag);
  bool get _hasHold => _syncHandler.positionToListener.values.any((element) => element.hasHold);

  LinkScrollControllerMixin? _findParent(bool Function(LinkScrollControllerMixin parent) test) {
    if (_internalParent == null) {
      return null;
    }
    if (test(_internalParent!)) {
      return _internalParent!;
    }

    return _internalParent!._findParent(test);
  }

  void linkActivedParent(
    double delta,
    DragUpdateDetails details,
    TextDirection textDirection,
  ) {
    if (_activedLinkParent != null) {
      return;
    }
    LinkScrollControllerMixin? activedParent;
    if (textDirection == TextDirection.rtl) {
      delta = -delta;
    }

    if (delta < 0 && _extentAfter == 0) {
      activedParent = _findParent((parent) => parent._extentAfter != 0);
    } else if (delta > 0 && _extentBefore == 0) {
      activedParent = _findParent((parent) => parent._extentBefore != 0);
    }

    if (activedParent != null) {
      _activedLinkParent = activedParent;
      activedParent.handleDragDown(null);
      activedParent.handleDragStart(
        DragStartDetails(
          globalPosition: details.globalPosition,
          localPosition: details.localPosition,
          sourceTimeStamp: details.sourceTimeStamp,
        ),
      );
    }
  }

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
    _syncHandler.forceCancel();
    super.dispose();
  }
}
