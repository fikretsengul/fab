import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'gesture_mixin.dart';

PageMetrics _getTestPageMetrics(BuildContext context) {
  return PageMetrics(
    axisDirection: AxisDirection.down,
    minScrollExtent: 0,
    maxScrollExtent: 10,
    pixels: 5,
    viewportDimension: 10,
    viewportFraction: 1,
    devicePixelRatio: View.of(context).devicePixelRatio,
  );
}

abstract class GestureStateMixin<T extends StatefulWidget> extends State<T> with GestureMixin {
  Map<Type, GestureRecognizerFactory>? _gestureRecognizers;
  Map<Type, GestureRecognizerFactory>? get gestureRecognizers => _gestureRecognizers;

  // widget.physics
  ScrollPhysics? get physics;

  TextDirection? get textDirection => Directionality.maybeOf(context);

  Axis get scrollDirection;
  bool get canDrag => physics?.shouldAcceptUserOffset(_getTestPageMetrics(context)) ?? true;
  ScrollPhysics? get usedScrollPhysics => _physics;
  ScrollPhysics? _physics;

  @override
  //@mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    updatePhysics();
    initGestureRecognizers();
  }

  // @override
  // //@mustCallSuper
  // void didUpdateWidget(covariant oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   updatePhysics();
  //   initGestureRecognizers();
  // }

  // Only call this from places that will definitely trigger a rebuild.
  void updatePhysics() {
    _physics = getScrollPhysics();
  }

  ScrollPhysics? getScrollPhysics() {
    final configuration = ScrollConfiguration.of(context);
    var temp = configuration.getScrollPhysics(context);
    if (physics != null) {
      temp = physics!.applyTo(temp);
    }
    return temp;
  }

  void initGestureRecognizers() {
    if (canDrag) {
      switch (scrollDirection) {
        case Axis.horizontal:
          _gestureRecognizers = <Type, GestureRecognizerFactory>{
            HorizontalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
              HorizontalDragGestureRecognizer.new,
              (instance) {
                instance
                  ..onDown = handleDragDown
                  ..onStart = handleDragStart
                  ..onUpdate = handleDragUpdate
                  ..onEnd = handleDragEnd
                  ..onCancel = handleDragCancel
                  ..minFlingDistance = _physics?.minFlingDistance
                  ..minFlingVelocity = _physics?.minFlingVelocity
                  ..maxFlingVelocity = _physics?.maxFlingVelocity;
              },
            ),
          };

        case Axis.vertical:
          _gestureRecognizers = <Type, GestureRecognizerFactory>{
            VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
              VerticalDragGestureRecognizer.new,
              (instance) {
                instance
                  ..onDown = handleDragDown
                  ..onStart = handleDragStart
                  ..onUpdate = handleDragUpdate
                  ..onEnd = handleDragEnd
                  ..onCancel = handleDragCancel
                  ..minFlingDistance = _physics?.minFlingDistance
                  ..minFlingVelocity = _physics?.minFlingVelocity
                  ..maxFlingVelocity = _physics?.maxFlingVelocity;
              },
            ),
          };
        default:
      }
    } else {
      _gestureRecognizers = const <Type, GestureRecognizerFactory>{};
      forceCancel();
    }
  }

  Widget buildGestureDetector({required Widget child}) {
    if (_gestureRecognizers == null) {
      return child;
    }
    return RawGestureDetector(
      gestures: _gestureRecognizers!,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
