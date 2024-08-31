import 'package:flutter/widgets.dart';

import 'gesture/gesture_state_mixin.dart';
import 'sync_scroll_controller.dart';

/// class MyWidget extends StatefulWidget {
///   const MyWidget({Key? key}) : super(key: key);
///
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends SyncScrollState<MyWidget> {
///   @override
///   Widget build(BuildContext context) {
///       return buildGestureDetector(child:Container());
///   }
///
///   @override
///   ScrollPhysics? get physics => throw UnimplementedError();
///
///   @override
///   Axis get scrollDirection => throw UnimplementedError();
///
///   @override
///   SyncScrollControllerMixin get syncScrollController =>
///       throw UnimplementedError();
/// }

abstract class SyncScrollState<T extends StatefulWidget> extends GestureStateMixin<T> {
  SyncScrollControllerMixin get syncScrollController;

  @override
  void handleDragDown(DragDownDetails details) {
    syncScrollController.forceCancel();
    syncScrollController.handleDragDown(details);
  }

  @override
  void handleDragStart(DragStartDetails details) {
    syncScrollController.handleDragStart(details);
  }

  @override
  void handleDragUpdate(DragUpdateDetails details) {
    syncScrollController.handleDragUpdate(details);
  }

  @override
  void handleDragEnd(DragEndDetails details) {
    syncScrollController.handleDragEnd(details);
  }

  @override
  void handleDragCancel() {
    syncScrollController.handleDragCancel();
  }

  @override
  void forceCancel() {
    syncScrollController.forceCancel();
  }
}
