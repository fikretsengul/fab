import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'link_controller.dart';
import 'sync_scroll_controller.dart';
import 'sync_scroll_state.dart';

/// class MyWidget extends StatefulWidget {
///   const MyWidget({Key? key}) : super(key: key);
///
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends LinkScrollState<MyWidget> {
///   @override
///   Widget build(BuildContext context) {
///     return buildGestureDetector(child:Container());
///   }
///
///   @override
///   LinkScrollControllerMixin get linkScrollController =>
///       throw UnimplementedError();
///
///   @override
///   ScrollPhysics? get physics => throw UnimplementedError();
///
///   @override
///   Axis get scrollDirection => throw UnimplementedError();
///
///   @override
///   void didChangeDependencies() {
///     // to something
///     // call super after linkScrollController is ready
///     super.didChangeDependencies();
///   }
///
///   @override
///   void didUpdateWidget(covariant MyWidget oldWidget) {
///     // to something
///     // call super after linkScrollController is ready
///     super.didUpdateWidget(oldWidget);
///   }
///
///   @override
///   bool get link => true;
///
///   // must override this method
///   @override
///   void linkParent<S extends StatefulWidget, T extends LinkScrollState<S>>() {
///     // link parent base on your case
///     super.linkParent<ExtendedTabBarView, ExtendedTabBarViewState>();
///   }
/// }

abstract class LinkScrollState<T extends StatefulWidget> extends SyncScrollState<T> {
  LinkScrollControllerMixin get linkScrollController;

  @override
  SyncScrollControllerMixin get syncScrollController => linkScrollController;

  bool get link;

  @override
  @mustCallSuper
  void didChangeDependencies() {
    linkParent();
    super.didChangeDependencies();
  }

  @override
  @mustCallSuper
  void didUpdateWidget(covariant T oldWidget) {
    linkParent();
    super.didUpdateWidget(oldWidget);
  }

  @mustCallSuper
  void linkParent<S extends StatefulWidget, T extends LinkScrollState<S>>() {
    linkScrollController.unlinkParent();
    if (link) {
      linkScrollController.linkParent<S, T>(context);
    }
  }

  @override
  void handleDragUpdate(DragUpdateDetails details) {
    _handleParentController(details);
    super.handleDragUpdate(details);
  }

  void _handleParentController(DragUpdateDetails details) {
    if (linkScrollController.parentIsNotNull) {
      final delta = scrollDirection == Axis.horizontal ? details.delta.dx : details.delta.dy;

      linkScrollController.linkActivedParent(
        delta,
        details,
        textDirection ?? TextDirection.ltr,
      );
    }
  }
}
