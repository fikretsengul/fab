import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/bar/bar.dart';

class BarRoute<T> extends OverlayRoute<T> {
  BarRoute({
    required this.bar,
    super.settings,
  })  : _builder = Builder(
          builder: (BuildContext innerContext) {
            return GestureDetector(
              onTap: bar.onTap != null ? () => bar.onTap!(bar) : null,
              child: bar,
            );
          },
        ),
        _onStatusChanged = bar.onStatusChanged {
    _configureAlignment(bar.barPosition);
  }

  final Bar<dynamic> bar;
  BarStatus? currentStatus;

  /// This string is a workaround until Dismissible supports a returning item.
  String dismissibleKeyGen = '';

  Animation<Alignment>? _animation;
  final Builder _builder;
  AnimationController? _controller;
  Alignment? _endAlignment;
  Animation<num>? _filterBlurAnimation;
  Animation<Color?>? _filterColorAnimation;
  Alignment? _initialAlignment;
  final BarStatusCallback? _onStatusChanged;
  T? _result;
  Timer? _timer;
  final Completer<T> _transitionCompleter = Completer<T>();
  bool _wasDismissedBySwipe = false;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final overlays = <OverlayEntry>[];

    if (bar.blockBackgroundInteraction) {
      overlays.add(
        OverlayEntry(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: bar.isDismissible ? bar.dismiss : null,
              child: _createBackgroundOverlay(),
            );
          },
          opaque: opaque,
        ),
      );
    }

    overlays.add(
      OverlayEntry(
        builder: (BuildContext context) {
          return Semantics(
            focused: false,
            container: true,
            explicitChildNodes: true,
            child: AlignTransition(
              alignment: _animation!,
              child: bar.isDismissible ? _getDismissibleBar() : _getBar(),
            ),
          );
        },
        opaque: opaque,
      ),
    );

    return overlays;
  }

  @override
  bool didPop(T? result) {
    assert(
      _controller != null,
      '$runtimeType.didPop called before calling install() or after calling dispose().',
    );
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot reuse a $runtimeType after disposing it.',
    );

    _result = result;
    _cancelTimer();

    if (_wasDismissedBySwipe) {
      Timer(const Duration(milliseconds: 200), () {
        _controller!.reset();
      });

      _wasDismissedBySwipe = false;
    } else {
      _controller!.reverse();
    }

    return super.didPop(result);
  }

  @override
  TickerFuture didPush() {
    assert(
      _controller != null,
      '$runtimeType.didPush called before calling install() or after calling dispose().',
    );
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot reuse a $runtimeType after disposing it.',
    );
    _animation!.addStatusListener(_handleStatusChanged);
    _configureTimer();
    super.didPush();

    return _controller!.forward();
  }

  @override
  void didReplace(Route<dynamic>? oldRoute) {
    assert(
      _controller != null,
      '$runtimeType.didReplace called before calling install() or after calling dispose().',
    );
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot reuse a $runtimeType after disposing it.',
    );
    if (oldRoute is BarRoute) {
      _controller!.value = oldRoute._controller!.value;
    }
    _animation!.addStatusListener(_handleStatusChanged);
    super.didReplace(oldRoute);
  }

  @override
  void dispose() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot dispose a $runtimeType twice.',
    );
    _controller?.dispose();
    _transitionCompleter.complete(_result);
    super.dispose();
  }

  @override
  bool get finishedWhenPopped => _controller!.status == AnimationStatus.dismissed;

  @override
  void install() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot install a $runtimeType after disposing it.',
    );
    _controller = createAnimationController();
    assert(
      _controller != null,
      '$runtimeType.createAnimationController() returned null.',
    );
    _filterBlurAnimation = createBlurFilterAnimation();
    _filterColorAnimation = createColorFilterAnimation();
    _animation = createAnimation();
    assert(_animation != null, '$runtimeType.createAnimation() returned null.');
    super.install();
  }

  @override
  Future<RoutePopDisposition> willPop() {
    if (!bar.isDismissible) {
      return Future.value(RoutePopDisposition.doNotPop);
    }

    return Future.value(RoutePopDisposition.pop);
  }

  Future<T> get completed => _transitionCompleter.future;

  bool get opaque => false;

  /// The animation that drives the route's transition and the previous route's
  /// forward transition.
  Animation<Alignment>? get animation => _animation;

  /// The animation controller that the route uses to drive the transitions.
  ///
  /// The animation itself is exposed by the [animation] property.
  @protected
  AnimationController? get controller => _controller;

  /// Called to create the animation controller that will drive the transitions to
  /// this route from the previous one, and back to the previous route from this
  /// one.
  AnimationController createAnimationController() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot reuse a $runtimeType after disposing it.',
    );
    assert(
      bar.animationDuration >= Duration.zero,
      'Animation duration must bigger than zero!',
    );

    return AnimationController(
      duration: bar.animationDuration,
      vsync: navigator!,
    );
  }

  /// Called to create the animation that exposes the current progress of
  /// the transition controlled by the animation controller created by
  /// [createAnimationController()].
  Animation<Alignment> createAnimation() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot reuse a $runtimeType after disposing it.',
    );
    assert(
      _controller != null,
      'Controller cannot be null!',
    );

    return AlignmentTween(begin: _initialAlignment, end: _endAlignment).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: bar.forwardAnimationCurve,
        reverseCurve: bar.reverseAnimationCurve,
      ),
    );
  }

  Animation<num>? createBlurFilterAnimation() {
    if (bar.routeBlur == null) return null;

    return Tween(begin: 0, end: bar.routeBlur).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(
          0,
          0.35,
          curve: Curves.easeInOutCirc,
        ),
      ),
    );
  }

  Animation<Color?>? createColorFilterAnimation() {
    if (bar.routeColor == null) return null;

    return ColorTween(begin: Colors.transparent, end: bar.routeColor).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(
          0,
          0.35,
          curve: Curves.easeInOutCirc,
        ),
      ),
    );
  }

  /// Whether this route can perform a transition to the given route.
  ///
  /// Subclasses can override this method to restrict the set of routes they
  /// need to coordinate transitions with.
  bool canTransitionTo() => true;

  /// Whether this route can perform a transition from the given route.
  ///
  /// Subclasses can override this method to restrict the set of routes they
  /// need to coordinate transitions with.
  bool canTransitionFrom() => true;

  void _configureAlignment(BarPosition barPosition) {
    switch (barPosition) {
      case BarPosition.top:
        {
          _initialAlignment = const Alignment(-1, -2);
          _endAlignment = bar.endOffset != null
              ? Alignment.topLeft + Alignment(bar.endOffset!.dx, bar.endOffset!.dy)
              : Alignment.topLeft;
          break;
        }
      case BarPosition.bottom:
        {
          _initialAlignment = const Alignment(-1, 2);
          _endAlignment = bar.endOffset != null
              ? Alignment.topLeft + Alignment(bar.endOffset!.dx, bar.endOffset!.dy)
              : Alignment.topLeft;
          break;
        }
    }
  }

  Widget _createBackgroundOverlay() {
    if (_filterBlurAnimation != null && _filterColorAnimation != null) {
      return AnimatedBuilder(
        animation: _filterBlurAnimation!,
        builder: (context, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _filterBlurAnimation!.value.toDouble(),
              sigmaY: _filterBlurAnimation!.value.toDouble(),
            ),
            child: Container(
              constraints: const BoxConstraints.expand(),
              color: _filterColorAnimation!.value,
            ),
          );
        },
      );
    }

    if (_filterBlurAnimation != null) {
      return AnimatedBuilder(
        animation: _filterBlurAnimation!,
        builder: (context, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _filterBlurAnimation!.value.toDouble(),
              sigmaY: _filterBlurAnimation!.value.toDouble(),
            ),
            child: Container(
              constraints: const BoxConstraints.expand(),
              color: Colors.transparent,
            ),
          );
        },
      );
    }

    if (_filterColorAnimation != null) {
      AnimatedBuilder(
        animation: _filterColorAnimation!,
        builder: (context, child) {
          return Container(
            constraints: const BoxConstraints.expand(),
            color: _filterColorAnimation!.value,
          );
        },
      );
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.transparent,
    );
  }

  Widget _getDismissibleBar() {
    return Dismissible(
      direction: _getDismissDirection(),
      resizeDuration: null,
      confirmDismiss: (_) {
        if (currentStatus == BarStatus.isAppearing || currentStatus == BarStatus.isHiding) {
          return Future.value(false);
        }

        return Future.value(true);
      },
      key: Key(dismissibleKeyGen),
      onDismissed: (_) {
        dismissibleKeyGen += '1';
        _cancelTimer();
        _wasDismissedBySwipe = true;

        if (isCurrent) {
          navigator!.pop();
        } else {
          navigator!.removeRoute(this);
        }
      },
      child: _getBar(),
    );
  }

  DismissDirection _getDismissDirection() {
    return bar.dismissDirection == BarDismissDirection.horizontal
        ? DismissDirection.horizontal
        : bar.barPosition == BarPosition.top
            ? DismissDirection.up
            : DismissDirection.down;
  }

  Widget _getBar() {
    return Container(
      margin: bar.margin,
      child: _builder,
    );
  }

  // Copy of `routes.dart`.
  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        currentStatus = BarStatus.showing;
        _onStatusChanged?.call(currentStatus);
        if (overlayEntries.isNotEmpty) overlayEntries.first.opaque = opaque;

        break;
      case AnimationStatus.forward:
        currentStatus = BarStatus.isAppearing;
        _onStatusChanged?.call(currentStatus);
        break;
      case AnimationStatus.reverse:
        currentStatus = BarStatus.isHiding;
        _onStatusChanged?.call(currentStatus);
        if (overlayEntries.isNotEmpty) overlayEntries.first.opaque = false;
        break;
      case AnimationStatus.dismissed:
        assert(
          !overlayEntries.first.opaque,
          'Overlay entries must not be opaque!',
        );
        // We might still be the current route if a subclass is controlling the
        // the transition and hits the dismissed status. For example, the iOS
        // back gesture drives this animation to the dismissed status before
        // popping the navigator.
        currentStatus = BarStatus.dismissed;
        _onStatusChanged?.call(currentStatus);

        if (!isCurrent) {
          navigator!.finalizeRoute(this);
          if (overlayEntries.isNotEmpty) {
            overlayEntries.clear();
          }
          assert(
            overlayEntries.isEmpty,
            'Overlay entries cannot be empty!',
          );
        }
        break;
    }
    changedInternalState();
  }

  void _configureTimer() {
    if (bar.duration != null) {
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
      _timer = Timer(bar.duration!, () {
        if (isCurrent) {
          navigator!.pop();
        } else if (isActive) {
          navigator!.removeRoute(this);
        }
      });
    } else {
      if (_timer != null) {
        _timer!.cancel();
      }
    }
  }

  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}

BarRoute<dynamic> showBar<T>({required Bar<dynamic> bar}) {
  return BarRoute<T>(
    bar: bar,
    settings: const RouteSettings(name: barRouteName),
  );
}
