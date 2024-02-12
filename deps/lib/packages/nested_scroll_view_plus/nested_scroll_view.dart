// ignore_for_file: max_lines_for_file, avoid_empty_blocks, avoid_widget_state_public_members, avoid_returning_widgets, boolean_prefix

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Last updated: [Flutter 3.19.0-5.0.pre](https://github.com/flutter/flutter/commit/e5f62cc5a029469f46464a6930075731ce42a94d)

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'multi_sliver/multi_sliver.dart';

part 'nested_scroll_view_inner.dart';
part 'nested_scroll_view_outer.dart';
part 'nested_scroll_view_plus.dart';

/// Signature used by [OriginalNestedScrollView] for building its header.
///
/// The `innerBoxIsScrolled` argument is typically used to control the
/// [SliverAppBar.forceElevated] property to ensure that the app bar shows a
/// shadow, since it would otherwise not necessarily be aware that it had
/// content ostensibly below it.
typedef OriginalNestedScrollViewHeaderSliversBuilder = List<Widget> Function(
  BuildContext context,
  bool innerBoxIsScrolled,
);

/// A scrolling view inside of which can be nested other scrolling views, with
/// their scroll positions being intrinsically linked.
///
/// The most common use case for this widget is a scrollable view with a
/// flexible [SliverAppBar] containing a [TabBar] in the header (built by
/// [headerSliverBuilder], and with a [TabBarView] in the [body], such that the
/// scrollable view's contents vary based on which tab is visible.
///
/// ## Motivation
///
/// In a normal [ScrollView], there is one set of slivers (the components of the
/// scrolling view). If one of those slivers hosted a [TabBarView] which scrolls
/// in the opposite direction (e.g. allowing the user to swipe horizontally
/// between the pages represented by the tabs, while the list scrolls
/// vertically), then any list inside that [TabBarView] would not interact with
/// the outer [ScrollView]. For example, flinging the inner list to scroll to
/// the top would not cause a collapsed [SliverAppBar] in the outer [ScrollView]
/// to expand.
///
/// [OriginalNestedScrollView] solves this problem by providing custom
/// [ScrollController]s for the outer [ScrollView] and the inner [ScrollView]s
/// (those inside the [TabBarView], hooking them together so that they appear,
/// to the user, as one coherent scroll view.
///
/// {@tool dartpad}
/// This example shows a [OriginalNestedScrollView] whose header is the combination of a
/// [TabBar] in a [SliverAppBar] and whose body is a [TabBarView]. It uses a
/// [OriginalSliverOverlapAbsorber]/[OriginalSliverOverlapInjector] pair to make the inner lists
/// align correctly, and it uses [SafeArea] to avoid any horizontal disturbances
/// (e.g. the "notch" on iOS when the phone is horizontal). In addition,
/// [PageStorageKey]s are used to remember the scroll position of each tab's
/// list.
///
/// ** See code in examples/api/lib/widgets/nested_scroll_view/nested_scroll_view.0.dart **
/// {@end-tool}
///
/// ## [SliverAppBar]s with [OriginalNestedScrollView]s
///
/// Using a [SliverAppBar] in the outer scroll view, or [headerSliverBuilder],
/// of a [OriginalNestedScrollView] may require special configurations in order to work
/// as it would if the outer and inner were one single scroll view, like a
/// [CustomScrollView].
///
/// ### Pinned [SliverAppBar]s
///
/// A pinned [SliverAppBar] works in a [OriginalNestedScrollView] exactly as it would in
/// another scroll view, like [CustomScrollView]. When using
/// [SliverAppBar.pinned], the app bar remains visible at the top of the scroll
/// view. The app bar can still expand and contract as the user scrolls, but it
/// will remain visible rather than being scrolled out of view.
///
/// This works naturally in a [OriginalNestedScrollView], as the pinned [SliverAppBar]
/// is not expected to move in or out of the visible portion of the viewport.
/// As the inner or outer [Scrollable]s are moved, the app bar persists as
/// expected.
///
/// If the app bar is floating, pinned, and using an expanded height, follow the
/// floating convention laid out below.
///
/// ### Floating [SliverAppBar]s
///
/// When placed in the outer scrollable, or the [headerSliverBuilder],
/// a [SliverAppBar] that floats, using [SliverAppBar.floating] will not be
/// triggered to float over the inner scroll view, or [body], automatically.
///
/// This is because a floating app bar uses the scroll offset of its own
/// [Scrollable] to dictate the floating action. Being two separate inner and
/// outer [Scrollable]s, a [SliverAppBar] in the outer header is not aware of
/// changes in the scroll offset of the inner body.
///
/// In order to float the outer, use [OriginalNestedScrollView.floatHeaderSlivers]. When
/// set to true, the nested scrolling coordinator will prioritize floating in
/// the header slivers before applying the remaining drag to the body.
///
/// Furthermore, the `floatHeaderSlivers` flag should also be used when using an
/// app bar that is floating, pinned, and has an expanded height. In this
/// configuration, the flexible space of the app bar will open and collapse,
/// while the primary portion of the app bar remains pinned.
///
/// {@tool dartpad}
/// This simple example shows a [OriginalNestedScrollView] whose header contains a
/// floating [SliverAppBar]. By using the [floatHeaderSlivers] property, the
/// floating behavior is coordinated between the outer and inner [Scrollable]s,
/// so it behaves as it would in a single scrollable.
///
/// ** See code in examples/api/lib/widgets/nested_scroll_view/nested_scroll_view.1.dart **
/// {@end-tool}
///
/// ### Snapping [SliverAppBar]s
///
/// Floating [SliverAppBar]s also have the option to perform a snapping animation.
/// If [SliverAppBar.snap] is true, then a scroll that exposes the floating app
/// bar will trigger an animation that slides the entire app bar into view.
/// Similarly if a scroll dismisses the app bar, the animation will slide the
/// app bar completely out of view.
///
/// It is possible with a [OriginalNestedScrollView] to perform just the snapping
/// animation without floating the app bar in and out. By not using the
/// [OriginalNestedScrollView.floatHeaderSlivers], the app bar will snap in and out
/// without floating.
///
/// The [SliverAppBar.snap] animation should be used in conjunction with the
/// [OriginalSliverOverlapAbsorber] and  [OriginalSliverOverlapInjector] widgets when
/// implemented in a [OriginalNestedScrollView]. These widgets take any overlapping
/// behavior of the [SliverAppBar] in the header and redirect it to the
/// [OriginalSliverOverlapInjector] in the body. If it is missing, then it is possible
/// for the nested "inner" scroll view below to end up under the [SliverAppBar]
/// even when the inner scroll view thinks it has not been scrolled.
///
/// {@tool dartpad}
/// This simple example shows a [OriginalNestedScrollView] whose header contains a
/// snapping, floating [SliverAppBar]. _Without_ setting any additional flags,
/// e.g [OriginalNestedScrollView.floatHeaderSlivers], the [SliverAppBar] will animate
/// in and out without floating. The [OriginalSliverOverlapAbsorber] and
/// [OriginalSliverOverlapInjector] maintain the proper alignment between the two
/// separate scroll views.
///
/// ** See code in examples/api/lib/widgets/nested_scroll_view/nested_scroll_view.2.dart **
/// {@end-tool}
///
/// ### Snapping and Floating [SliverAppBar]s
///
// See https://github.com/flutter/flutter/issues/59189
/// Currently, [OriginalNestedScrollView] does not support simultaneously floating and
/// snapping the outer scrollable, e.g. when using [SliverAppBar.floating] &
/// [SliverAppBar.snap] at the same time.
///
/// ### Stretching [SliverAppBar]s
///
// See https://github.com/flutter/flutter/issues/54059
/// Currently, [OriginalNestedScrollView] does not support stretching the outer
/// scrollable, e.g. when using [SliverAppBar.stretch].
///
/// See also:
///
///  * [SliverAppBar], for examples on different configurations like floating,
///    pinned and snap behaviors.
///  * [OriginalSliverOverlapAbsorber], a sliver that wraps another, forcing its layout
///    extent to be treated as overlap.
///  * [OriginalSliverOverlapInjector], a sliver that has a sliver geometry based on
///    the values stored in a [OriginalOverlapAbsorberHandle].
class OriginalNestedScrollView extends StatefulWidget {
  /// Creates a nested scroll view.
  ///
  /// The [reverse], [headerSliverBuilder], and [body] arguments must not be
  /// null.
  const OriginalNestedScrollView({
    required this.headerSliverBuilder,
    required this.body,
    super.key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.floatHeaderSlivers = false,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scrollBehavior,
  });

  /// An object that can be used to control the position to which the outer
  /// scroll view is scrolled.
  final ScrollController? controller;

  /// {@macro flutter.widgets.scroll_view.scrollDirection}
  ///
  /// This property only applies to the [Axis] of the outer scroll view,
  /// composed of the slivers returned from [headerSliverBuilder]. Since the
  /// inner scroll view is not directly configured by the [NestedScrollView],
  /// for the axes to match, configure the scroll view of the [body] the same
  /// way if they are expected to scroll in the same orientation. This allows
  /// for flexible configurations of the NestedScrollView.
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// This property only applies to the outer scroll view, composed of the
  /// slivers returned from [headerSliverBuilder]. Since the inner scroll view
  /// is not directly configured by the [NestedScrollView]. For both to scroll
  /// in reverse, configure the scroll view of the [body] the same way if they
  /// are expected to match. This allows for flexible configurations of the
  /// NestedScrollView.
  ///
  /// Defaults to false.
  final bool reverse;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view (providing a custom implementation of
  /// [ScrollPhysics.createBallisticSimulation] allows this particular aspect of
  /// the physics to be overridden).
  ///
  /// If an explicit [ScrollBehavior] is provided to [scrollBehavior], the
  /// [ScrollPhysics] provided by that behavior will take precedence after
  /// [physics].
  ///
  /// Defaults to matching platform conventions.
  ///
  /// The [ScrollPhysics.applyBoundaryConditions] implementation of the provided
  /// object should not allow scrolling outside the scroll extent range
  /// described by the [ScrollMetrics.minScrollExtent] and
  /// [ScrollMetrics.maxScrollExtent] properties passed to that method. If that
  /// invariant is not maintained, the nested scroll view may respond to user
  /// scrolling erratically.
  ///
  /// This property only applies to the outer scroll view, composed of the
  /// slivers returned from [headerSliverBuilder]. Since the inner scroll view
  /// is not directly configured by the [NestedScrollView]. For both to scroll
  /// with the same [ScrollPhysics], configure the scroll view of the [body]
  /// the same way if they are expected to match, or use a [ScrollBehavior] as
  /// an ancestor so both the inner and outer scroll views inherit the same
  /// [ScrollPhysics]. This allows for flexible configurations of the
  /// NestedScrollView.
  ///
  /// The [ScrollPhysics] also determine whether or not the [NestedScrollView]
  /// can accept input from the user to change the scroll offset. For example,
  /// [NeverScrollableScrollPhysics] typically will not allow the user to drag a
  /// scroll view, but in this case, if one of the two scroll views can be
  /// dragged, then dragging will be allowed. Configuring both scroll views with
  /// [NeverScrollableScrollPhysics] will disallow dragging in this case.
  final ScrollPhysics? physics;

  /// A builder for any widgets that are to precede the inner scroll views (as
  /// given by [body]).
  ///
  /// Typically this is used to create a [SliverAppBar] with a [TabBar].
  final OriginalNestedScrollViewHeaderSliversBuilder headerSliverBuilder;

  /// The widget to show inside the [OriginalNestedScrollView].
  ///
  /// Typically this will be [TabBarView].
  ///
  /// The [body] is built in a context that provides a [PrimaryScrollController]
  /// that interacts with the [OriginalNestedScrollView]'s scroll controller. Any
  /// [ListView] or other [Scrollable]-based widget inside the [body] that is
  /// intended to scroll with the [OriginalNestedScrollView] should therefore not be
  /// given an explicit [ScrollController], instead allowing it to default to
  /// the [PrimaryScrollController] provided by the [OriginalNestedScrollView].
  final Widget body;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Whether or not the [OriginalNestedScrollView]'s coordinator should prioritize the
  /// outer scrollable over the inner when scrolling back.
  ///
  /// This is useful for an outer scrollable containing a [SliverAppBar] that
  /// is expected to float.
  final bool floatHeaderSlivers;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.shadow.scrollBehavior}
  ///
  /// [ScrollBehavior]s also provide [ScrollPhysics]. If an explicit
  /// [ScrollPhysics] is provided in [physics], it will take precedence,
  /// followed by [scrollBehavior], and then the inherited ancestor
  /// [ScrollBehavior].
  ///
  /// The [ScrollBehavior] of the inherited [ScrollConfiguration] will be
  /// modified by default to not apply a [Scrollbar]. This is because the
  /// OriginalNestedScrollView cannot assume the configuration of the outer and inner
  /// [Scrollable] widgets, particularly whether to treat them as one scrollable,
  /// or separate and desirous of unique behaviors.
  final ScrollBehavior? scrollBehavior;

  /// Returns the [OriginalOverlapAbsorberHandle] of the nearest ancestor
  /// [OriginalNestedScrollView].
  ///
  /// This is necessary to configure the [OriginalSliverOverlapAbsorber] and
  /// [OriginalSliverOverlapInjector] widgets.
  ///
  /// For sample code showing how to use this method, see the [OriginalNestedScrollView]
  /// documentation.
  static OriginalOverlapAbsorberHandle sliverOverlapAbsorberHandleFor(
    BuildContext context,
  ) {
    final target = context.dependOnInheritedWidgetOfExactType<_OriginalInheritedNestedScrollView>();
    assert(
      target != null,
      'OriginalNestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a OriginalNestedScrollView.',
    );

    return target!.state._absorberHandle;
  }

  List<Widget> _buildSlivers(
    BuildContext context,
    ScrollController innerController,
    bool bodyIsScrolled,
  ) {
    return <Widget>[
      ...headerSliverBuilder(context, bodyIsScrolled),
      SliverFillRemaining(
        // The inner (body) scroll view must use this scroll controller so that
        // the independent scroll positions can be kept in sync.
        child: PrimaryScrollController(
          // The inner scroll view should always inherit this
          // PrimaryScrollController, on every platform.
          automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
          // `PrimaryScrollController.scrollDirection` is not set, and so it is
          // restricted to the default Axis.vertical.
          // Ideally the inner and outer views would have the same
          // scroll direction, and so we could assume
          // `OriginalNestedScrollView.scrollDirection` for the PrimaryScrollController,
          // but use cases already exist where the axes are mismatched.
          // https://github.com/flutter/flutter/issues/102001
          controller: innerController,
          child: body,
        ),
      ),
    ];
  }

  @override
  NestedScrollViewStatePlus createState() => NestedScrollViewStatePlus();
}

/// The [State] for a [NestedScrollViewPlus].
///
/// The [ScrollController]s, [innerController] and [outerController], of the
/// [NestedScrollViewPlus]'s children may be accessed through its state. This is
/// useful for obtaining respective scroll positions in the [NestedScrollViewPlus].
///
/// If you want to access the inner or outer scroll controller of a
/// [NestedScrollViewPlus], you can get its [NestedScrollViewStatePlus] by supplying a
/// `GlobalKey<NestedScrollViewStatePlus>` to the [NestedScrollViewPlus.key] parameter).
///
/// {@tool dartpad}
/// [NestedScrollViewStatePlus] can be obtained using a [GlobalKey].
/// Using the following setup, you can access the inner scroll controller
/// using `globalKey.currentState.innerController`.
///
/// ** See code in examples/api/lib/widgets/nested_scroll_view/nested_scroll_view_state.0.dart **
/// {@end-tool}
class NestedScrollViewStatePlus extends State<OriginalNestedScrollView> {
  final OriginalOverlapAbsorberHandle _absorberHandle = OriginalOverlapAbsorberHandle();

  /// The [ScrollController] provided to the [ScrollView] in
  /// [OriginalNestedScrollView.body].
  ///
  /// Manipulating the [ScrollPosition] of this controller pushes the outer
  /// header sliver(s) up and out of view. The position of the [outerController]
  /// will be set to [ScrollPosition.maxScrollExtent], unless you use
  /// [ScrollPosition.setPixels].
  ///
  /// See also:
  ///
  ///  * [outerController], which exposes the [ScrollController] used by the
  ///    sliver(s) contained in [OriginalNestedScrollView.headerSliverBuilder].
  ScrollController get innerController => _coordinator!._innerController;

  /// The [ScrollController] provided to the [ScrollView] in
  /// [OriginalNestedScrollView.headerSliverBuilder].
  ///
  /// This is equivalent to [OriginalNestedScrollView.controller], if provided.
  ///
  /// Manipulating the [ScrollPosition] of this controller pushes the inner body
  /// sliver(s) down. The position of the [innerController] will be set to
  /// [ScrollPosition.minScrollExtent], unless you use
  /// [ScrollPosition.setPixels]. Visually, the inner body will be scrolled to
  /// its beginning.
  ///
  /// See also:
  ///
  ///  * [innerController], which exposes the [ScrollController] used by the
  ///    [ScrollView] contained in [OriginalNestedScrollView.body].
  ScrollController get outerController => _coordinator!._outerController;

  _OriginalNestedScrollCoordinator? _coordinator;

  @override
  void initState() {
    super.initState();
    _coordinator = _OriginalNestedScrollCoordinator(
      this,
      widget.controller,
      _handleHasScrolledBodyChanged,
      widget.floatHeaderSlivers,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _coordinator!.setParent(widget.controller);
  }

  @override
  void didUpdateWidget(OriginalNestedScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _coordinator!.setParent(widget.controller);
    }
  }

  @override
  void dispose() {
    _coordinator!.dispose();
    _coordinator = null;
    _absorberHandle.dispose();
    super.dispose();
  }

  bool? _lastHasScrolledBody;

  void _handleHasScrolledBodyChanged() {
    if (!mounted) {
      return;
    }
    final newHasScrolledBody = _coordinator!.hasScrolledBody;
    if (_lastHasScrolledBody != newHasScrolledBody) {
      setState(() {
        // _coordinator.hasScrolledBody changed (we use it in the build method)
        // (We record _lastHasScrolledBody in the build() method, rather than in
        // this setState call, because the build() method may be called more
        // often than just from here, and we want to only call setState when the
        // new value is different than the last built value.)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollPhysics = widget.physics?.applyTo(const ClampingScrollPhysics()) ??
        widget.scrollBehavior?.getScrollPhysics(context).applyTo(const ClampingScrollPhysics()) ??
        const ClampingScrollPhysics();

    return _OriginalInheritedNestedScrollView(
      state: this,
      child: Builder(
        builder: (context) {
          _lastHasScrolledBody = _coordinator!.hasScrolledBody;

          return _OriginalNestedScrollViewCustomScrollView(
            dragStartBehavior: widget.dragStartBehavior,
            scrollDirection: widget.scrollDirection,
            reverse: widget.reverse,
            physics: scrollPhysics,
            scrollBehavior: widget.scrollBehavior ?? ScrollConfiguration.of(context).copyWith(scrollbars: false),
            controller: _coordinator!._outerController,
            slivers: widget._buildSlivers(
              context,
              _coordinator!._innerController,
              _lastHasScrolledBody!,
            ),
            handle: _absorberHandle,
            clipBehavior: widget.clipBehavior,
            restorationId: widget.restorationId,
          );
        },
      ),
    );
  }
}

class _OriginalNestedScrollViewCustomScrollView extends CustomScrollView {
  const _OriginalNestedScrollViewCustomScrollView({
    required super.scrollDirection,
    required super.reverse,
    required ScrollPhysics super.physics,
    required ScrollBehavior super.scrollBehavior,
    required ScrollController super.controller,
    required super.slivers,
    required this.handle,
    required super.clipBehavior,
    super.dragStartBehavior,
    super.restorationId,
  });

  final OriginalOverlapAbsorberHandle handle;

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset offset,
    AxisDirection axisDirection,
    List<Widget> slivers,
  ) {
    assert(!shrinkWrap);

    return OriginalNestedScrollViewViewport(
      axisDirection: axisDirection,
      offset: offset,
      slivers: slivers,
      handle: handle,
      clipBehavior: clipBehavior,
    );
  }
}

class _OriginalInheritedNestedScrollView extends InheritedWidget {
  const _OriginalInheritedNestedScrollView({
    required this.state,
    required super.child,
  });

  final NestedScrollViewStatePlus state;

  @override
  bool updateShouldNotify(_OriginalInheritedNestedScrollView old) => state != old.state;
}

class _OriginalNestedScrollMetrics extends FixedScrollMetrics {
  _OriginalNestedScrollMetrics({
    required super.minScrollExtent,
    required super.maxScrollExtent,
    required super.pixels,
    required super.viewportDimension,
    required super.axisDirection,
    required super.devicePixelRatio,
    required this.minRange,
    required this.maxRange,
    required this.correctionOffset,
  });

  @override
  _OriginalNestedScrollMetrics copyWith({
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    double? minRange,
    double? maxRange,
    double? correctionOffset,
  }) {
    return _OriginalNestedScrollMetrics(
      minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : null),
      maxScrollExtent: maxScrollExtent ?? (hasContentDimensions ? this.maxScrollExtent : null),
      pixels: pixels ?? (hasPixels ? this.pixels : null),
      viewportDimension: viewportDimension ?? (hasViewportDimension ? this.viewportDimension : null),
      axisDirection: axisDirection ?? this.axisDirection,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      minRange: minRange ?? this.minRange,
      maxRange: maxRange ?? this.maxRange,
      correctionOffset: correctionOffset ?? this.correctionOffset,
    );
  }

  final double minRange;

  final double maxRange;

  final double correctionOffset;
}

class _OriginalNestedScrollCoordinator implements ScrollActivityDelegate, ScrollHoldController {
  _OriginalNestedScrollCoordinator(
    this._state,
    this._parent,
    this._onHasScrolledBodyChanged,
    this._floatHeaderSlivers,
  ) {
    // // stop duplicating code across disposables
    // // https://github.com/flutter/flutter/issues/137435
    // if (kFlutterMemoryAllocationsEnabled) {
    //   FlutterMemoryAllocations.instance.dispatchObjectCreated(
    //     library: 'package:flutter/widgets.dart',
    //     className: '$_OriginalNestedScrollCoordinator',
    //     object: this,
    //   );
    // }
    final initialScrollOffset = _parent?.initialScrollOffset ?? 0.0;
    _outerController = _OriginalNestedScrollController(
      this,
      initialScrollOffset: initialScrollOffset,
      debugLabel: 'outer',
    );
    _innerController = _OriginalNestedScrollController(
      this,
      debugLabel: 'inner',
    );
  }

  final NestedScrollViewStatePlus _state;
  ScrollController? _parent;
  final VoidCallback _onHasScrolledBodyChanged;
  final bool _floatHeaderSlivers;

  late _OriginalNestedScrollController _outerController;
  late _OriginalNestedScrollController _innerController;

  _OriginalNestedScrollPosition? get _outerPosition {
    if (!_outerController.hasClients) {
      return null;
    }

    return _outerController.nestedPositions.single;
  }

  Iterable<_OriginalNestedScrollPosition> get _innerPositions {
    return _innerController.nestedPositions;
  }

  bool get canScrollBody {
    final outer = _outerPosition;
    if (outer == null) {
      return true;
    }

    return outer.haveDimensions && outer.extentAfter == 0.0;
  }

  bool get hasScrolledBody {
    for (final position in _innerPositions) {
      if (!position.hasContentDimensions || !position.hasPixels) {
        // It's possible that OriginalNestedScrollView built twice before layout phase
        // in the same frame. This can happen when the FocusManager schedules a microTask
        // that marks OriginalNestedScrollView dirty during the warm up frame.
        // https://github.com/flutter/flutter/pull/75308
        continue;
      } else if (position.pixels > position.minScrollExtent) {
        return true;
      }
    }

    return false;
  }

  void updateShadow() {
    _onHasScrolledBodyChanged();
  }

  ScrollDirection get userScrollDirection => _userScrollDirection;
  ScrollDirection _userScrollDirection = ScrollDirection.idle;

  void updateUserScrollDirection(ScrollDirection value) {
    if (userScrollDirection == value) {
      return;
    }
    _userScrollDirection = value;
    _outerPosition!.didUpdateScrollDirection(value);
    for (final position in _innerPositions) {
      position.didUpdateScrollDirection(value);
    }
  }

  ScrollDragController? _currentDrag;

  void beginActivity(
    ScrollActivity newOuterActivity,
    ScrollActivity Function(_OriginalNestedScrollPosition position) innerActivityGetter,
  ) {
    _outerPosition!.beginActivity(newOuterActivity);
    var scrolling = newOuterActivity.isScrolling;
    for (final position in _innerPositions) {
      final newInnerActivity = innerActivityGetter(position);
      position.beginActivity(newInnerActivity);
      scrolling = scrolling && newInnerActivity.isScrolling;
    }
    _currentDrag?.dispose();
    _currentDrag = null;
    if (!scrolling) {
      updateUserScrollDirection(ScrollDirection.idle);
    }
  }

  @override
  AxisDirection get axisDirection => _outerPosition!.axisDirection;

  static IdleScrollActivity _createIdleScrollActivity(
    _OriginalNestedScrollPosition position,
  ) {
    return IdleScrollActivity(position);
  }

  @override
  void goIdle() {
    beginActivity(
      _createIdleScrollActivity(_outerPosition!),
      _createIdleScrollActivity,
    );
  }

  @override
  void goBallistic(double velocity) {
    beginActivity(
      createOuterBallisticScrollActivity(velocity),
      (position) {
        return createInnerBallisticScrollActivity(
          position,
          velocity,
        );
      },
    );
  }

  ScrollActivity createOuterBallisticScrollActivity(double velocity) {
    // This function creates a ballistic scroll for the outer scrollable.
    //
    // It assumes that the outer scrollable can't be overscrolled, and sets up a
    // ballistic scroll over the combined space of the innerPositions and the
    // outerPosition.

    // First we must pick a representative inner position that we will care
    // about. This is somewhat arbitrary. Ideally we'd pick the one that is "in
    // the center" but there isn't currently a good way to do that so we
    // arbitrarily pick the one that is the furthest away from the infinity we
    // are heading towards.
    _OriginalNestedScrollPosition? innerPosition;
    if (velocity != 0.0) {
      for (final position in _innerPositions) {
        if (innerPosition != null) {
          if (velocity > 0.0) {
            if (innerPosition.pixels < position.pixels) {
              continue;
            }
          } else {
            assert(velocity < 0.0);
            if (innerPosition.pixels > position.pixels) {
              continue;
            }
          }
        }
        innerPosition = position;
      }
    }

    if (innerPosition == null) {
      // It's either just us or a velocity=0 situation.
      return _outerPosition!.createBallisticScrollActivity(
        _outerPosition!.physics.createBallisticSimulation(
          _outerPosition!,
          velocity,
        ),
        mode: _OriginalNestedBallisticScrollActivityMode.independent,
      );
    }

    final metrics = _getMetrics(innerPosition, velocity);

    return _outerPosition!.createBallisticScrollActivity(
      _outerPosition!.physics.createBallisticSimulation(metrics, velocity),
      mode: _OriginalNestedBallisticScrollActivityMode.outer,
      metrics: metrics,
    );
  }

  @protected
  ScrollActivity createInnerBallisticScrollActivity(
    _OriginalNestedScrollPosition position,
    double velocity,
  ) {
    return position.createBallisticScrollActivity(
      position.physics.createBallisticSimulation(
        _getMetrics(position, velocity),
        velocity,
      ),
      mode: _OriginalNestedBallisticScrollActivityMode.inner,
    );
  }

  _OriginalNestedScrollMetrics _getMetrics(
    _OriginalNestedScrollPosition innerPosition,
    double velocity,
  ) {
    double pixels;
    double minRange;
    double maxRange;
    double correctionOffset;
    var extra = 0.0;
    if (innerPosition.pixels == innerPosition.minScrollExtent) {
      pixels = clampDouble(
        _outerPosition!.pixels,
        _outerPosition!.minScrollExtent,
        _outerPosition!.maxScrollExtent,
      ); // gracefully handle out-of-range outer positions
      minRange = _outerPosition!.minScrollExtent;
      maxRange = _outerPosition!.maxScrollExtent;
      assert(minRange <= maxRange);
      correctionOffset = 0.0;
    } else {
      assert(innerPosition.pixels != innerPosition.minScrollExtent);
      if (innerPosition.pixels < innerPosition.minScrollExtent) {
        pixels = innerPosition.pixels - innerPosition.minScrollExtent + _outerPosition!.minScrollExtent;
      } else {
        assert(innerPosition.pixels > innerPosition.minScrollExtent);
        pixels = innerPosition.pixels - innerPosition.minScrollExtent + _outerPosition!.maxScrollExtent;
      }
      if ((velocity > 0.0) && (innerPosition.pixels > innerPosition.minScrollExtent)) {
        // This handles going forward (fling up) and inner list is scrolled past
        // zero. We want to grab the extra pixels immediately to shrink.
        extra = _outerPosition!.maxScrollExtent - _outerPosition!.pixels;
        assert(extra >= 0.0);
        minRange = pixels;
        maxRange = pixels + extra;
        assert(minRange <= maxRange);
        correctionOffset = _outerPosition!.pixels - pixels;
      } else if ((velocity < 0.0) && (innerPosition.pixels < innerPosition.minScrollExtent)) {
        // This handles going backward (fling down) and inner list is
        // underscrolled. We want to grab the extra pixels immediately to grow.
        extra = _outerPosition!.pixels - _outerPosition!.minScrollExtent;
        assert(extra >= 0.0);
        minRange = pixels - extra;
        maxRange = pixels;
        assert(minRange <= maxRange);
        correctionOffset = _outerPosition!.pixels - pixels;
      } else {
        // This handles going forward (fling up) and inner list is
        // underscrolled, OR, going backward (fling down) and inner list is
        // scrolled past zero. We want to skip the pixels we don't need to grow
        // or shrink over.
        if (velocity > 0.0) {
          // shrinking
          extra = _outerPosition!.minScrollExtent - _outerPosition!.pixels;
        } else if (velocity < 0.0) {
          // growing
          extra = _outerPosition!.pixels - (_outerPosition!.maxScrollExtent - _outerPosition!.minScrollExtent);
        }
        assert(extra <= 0.0);
        minRange = _outerPosition!.minScrollExtent;
        maxRange = _outerPosition!.maxScrollExtent + extra;
        assert(minRange <= maxRange);
        correctionOffset = 0.0;
      }
    }

    return _OriginalNestedScrollMetrics(
      minScrollExtent: _outerPosition!.minScrollExtent,
      maxScrollExtent:
          _outerPosition!.maxScrollExtent + innerPosition.maxScrollExtent - innerPosition.minScrollExtent + extra,
      pixels: pixels,
      viewportDimension: _outerPosition!.viewportDimension,
      axisDirection: _outerPosition!.axisDirection,
      minRange: minRange,
      maxRange: maxRange,
      correctionOffset: correctionOffset,
      devicePixelRatio: _outerPosition!.devicePixelRatio,
    );
  }

  double unnestOffset(double value, _OriginalNestedScrollPosition source) {
    if (source == _outerPosition) {
      return clampDouble(
        value,
        _outerPosition!.minScrollExtent,
        _outerPosition!.maxScrollExtent,
      );
    }
    if (value < source.minScrollExtent) {
      return value - source.minScrollExtent + _outerPosition!.minScrollExtent;
    }

    return value - source.minScrollExtent + _outerPosition!.maxScrollExtent;
  }

  double nestOffset(double value, _OriginalNestedScrollPosition target) {
    if (target == _outerPosition) {
      return clampDouble(
        value,
        _outerPosition!.minScrollExtent,
        _outerPosition!.maxScrollExtent,
      );
    }
    if (value < _outerPosition!.minScrollExtent) {
      return value - _outerPosition!.minScrollExtent + target.minScrollExtent;
    }
    if (value > _outerPosition!.maxScrollExtent) {
      return value - _outerPosition!.maxScrollExtent + target.minScrollExtent;
    }

    return target.minScrollExtent;
  }

  void updateCanDrag() {
    if (!_outerPosition!.haveDimensions) {
      return;
    }

    var innerCanDrag = false;
    for (final position in _innerPositions) {
      if (!position.haveDimensions) {
        return;
      }
      innerCanDrag = innerCanDrag
          // This refers to the physics of the actual inner scroll position, not
          // the whole NestedScrollView, since it is possible to have different
          // ScrollPhysics for the inner and outer positions.
          ||
          position.physics.shouldAcceptUserOffset(position);
    }
    _outerPosition!.updateCanDrag(innerCanDrag);
  }

  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  }) async {
    final outerActivity = _outerPosition!.createDrivenScrollActivity(
      nestOffset(to, _outerPosition!),
      duration,
      curve,
    );
    final resultFutures = <Future<void>>[outerActivity.done];
    beginActivity(
      outerActivity,
      (position) {
        final innerActivity = position.createDrivenScrollActivity(
          nestOffset(to, position),
          duration,
          curve,
        );
        resultFutures.add(innerActivity.done);

        return innerActivity;
      },
    );
    await Future.wait<void>(resultFutures);
  }

  void jumpTo(double to) {
    goIdle();
    _outerPosition!.localJumpTo(nestOffset(to, _outerPosition!));
    for (final position in _innerPositions) {
      position.localJumpTo(nestOffset(to, position));
    }
    goBallistic(0);
  }

  void pointerScroll(double delta) {
    // If an update is made to pointer scrolling here, consider if the same
    // (or similar) change should be made in
    // ScrollPositionWithSingleContext.pointerScroll.
    if (delta == 0.0) {
      goBallistic(0);

      return;
    }

    goIdle();
    updateUserScrollDirection(
      delta < 0.0 ? ScrollDirection.forward : ScrollDirection.reverse,
    );

    // Handle notifications. Even if only one position actually receives
    // the delta, the OriginalNestedScrollView's intention is to treat multiple
    // ScrollPositions as one.
    _outerPosition!.isScrollingNotifier.value = true;
    _outerPosition!.didStartScroll();
    for (final position in _innerPositions) {
      position.isScrollingNotifier.value = true;
      position.didStartScroll();
    }

    if (_innerPositions.isEmpty) {
      // Does not enter overscroll.
      _outerPosition!.applyClampedPointerSignalUpdate(delta);
    } else if (delta > 0.0) {
      // Dragging "up" - delta is positive
      // Prioritize getting rid of any inner overscroll, and then the outer
      // view, so that the app bar will scroll out of the way asap.
      var outerDelta = delta;
      for (final position in _innerPositions) {
        if (position.pixels < 0.0) {
          // This inner position is in overscroll.
          final potentialOuterDelta = position.applyClampedPointerSignalUpdate(delta);
          // In case there are multiple positions in varying states of
          // overscroll, the first to 'reach' the outer view above takes
          // precedence.
          outerDelta = math.max(outerDelta, potentialOuterDelta);
        }
      }
      if (outerDelta.abs() > precisionErrorTolerance) {
        final innerDelta = _outerPosition!.applyClampedPointerSignalUpdate(
          outerDelta,
        );
        if (innerDelta != 0.0) {
          for (final position in _innerPositions) {
            position.applyClampedPointerSignalUpdate(innerDelta);
          }
        }
      }
    } else {
      // Dragging "down" - delta is negative
      var innerDelta = delta;
      // Apply delta to the outer header first if it is configured to float.
      if (_floatHeaderSlivers) {
        innerDelta = _outerPosition!.applyClampedPointerSignalUpdate(delta);
      }

      if (innerDelta != 0.0) {
        // Apply the innerDelta, if we have not floated in the outer scrollable,
        // any leftover delta after this will be passed on to the outer
        // scrollable by the outerDelta.
        var outerDelta = 0.0; // it will go negative if it changes
        for (final position in _innerPositions) {
          final overscroll = position.applyClampedPointerSignalUpdate(innerDelta);
          outerDelta = math.min(outerDelta, overscroll);
        }
        if (outerDelta != 0.0) {
          _outerPosition!.applyClampedPointerSignalUpdate(outerDelta);
        }
      }
    }

    _outerPosition!.didEndScroll();
    for (final position in _innerPositions) {
      position.didEndScroll();
    }
    goBallistic(0);
  }

  @override
  double setPixels(double newPixels) {
    assert(false);

    return 0;
  }

  ScrollHoldController hold(VoidCallback holdCancelCallback) {
    beginActivity(
      HoldScrollActivity(
        delegate: _outerPosition!,
        onHoldCanceled: holdCancelCallback,
      ),
      (position) => HoldScrollActivity(delegate: position),
    );

    return this;
  }

  @override
  void cancel() {
    goBallistic(0);
  }

  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    final drag = ScrollDragController(
      delegate: this,
      details: details,
      onDragCanceled: dragCancelCallback,
    );
    beginActivity(
      DragScrollActivity(_outerPosition!, drag),
      (position) => DragScrollActivity(position, drag),
    );
    assert(_currentDrag == null);
    _currentDrag = drag;

    return drag;
  }

  @override
  void applyUserOffset(double delta) {
    updateUserScrollDirection(
      delta > 0.0 ? ScrollDirection.forward : ScrollDirection.reverse,
    );
    assert(delta != 0.0);
    if (_innerPositions.isEmpty) {
      _outerPosition!.applyFullDragUpdate(delta);
    } else if (delta < 0.0) {
      // Dragging "up"
      // Prioritize getting rid of any inner overscroll, and then the outer
      // view, so that the app bar will scroll out of the way asap.
      var outerDelta = delta;
      for (final position in _innerPositions) {
        if (position.pixels < 0.0) {
          // This inner position is in overscroll.
          final potentialOuterDelta = position.applyClampedDragUpdate(delta);
          // In case there are multiple positions in varying states of
          // overscroll, the first to 'reach' the outer view above takes
          // precedence.
          outerDelta = math.max(outerDelta, potentialOuterDelta);
        }
      }
      if (outerDelta.abs() > precisionErrorTolerance) {
        final innerDelta = _outerPosition!.applyClampedDragUpdate(
          outerDelta,
        );
        if (innerDelta != 0.0) {
          for (final position in _innerPositions) {
            position.applyFullDragUpdate(innerDelta);
          }
        }
      }
    } else {
      // Dragging "down" - delta is positive
      var innerDelta = delta;
      // Apply delta to the outer header first if it is configured to float.
      if (_floatHeaderSlivers) {
        innerDelta = _outerPosition!.applyClampedDragUpdate(delta);
      }

      if (innerDelta != 0.0) {
        // Apply the innerDelta, if we have not floated in the outer scrollable,
        // any leftover delta after this will be passed on to the outer
        // scrollable by the outerDelta.
        var outerDelta = 0.0; // it will go positive if it changes
        final overscrolls = <double>[];
        final innerPositions = _innerPositions.toList();
        for (final position in innerPositions) {
          final overscroll = position.applyClampedDragUpdate(innerDelta);
          outerDelta = math.max(outerDelta, overscroll);
          overscrolls.add(overscroll);
        }
        if (outerDelta != 0.0) {
          outerDelta -= _outerPosition!.applyClampedDragUpdate(outerDelta);
        }

        // Now deal with any overscroll
        for (var i = 0; i < innerPositions.length; ++i) {
          final remainingDelta = overscrolls[i] - outerDelta;
          if (remainingDelta > 0.0) {
            innerPositions[i].applyFullDragUpdate(remainingDelta);
          }
        }
      }
    }
  }

  void setParent(ScrollController? value) {
    _parent = value;
    updateParent();
  }

  void updateParent() {
    _outerPosition?.setParent(
      _parent ?? PrimaryScrollController.maybeOf(_state.context),
    );
  }

  @mustCallSuper
  void dispose() {
    // if (kFlutterMemoryAllocationsEnabled) {
    //   FlutterMemoryAllocations.instance.dispatchObjectDisposed(object: this);
    // }
    _currentDrag?.dispose();
    _currentDrag = null;
    _outerController.dispose();
    _innerController.dispose();
  }

  @override
  String toString() =>
      '${objectRuntimeType(this, '_OriginalNestedScrollCoordinator')}(outer=$_outerController; inner=$_innerController)';
}

class _OriginalNestedScrollController extends ScrollController {
  _OriginalNestedScrollController(
    this.coordinator, {
    super.initialScrollOffset,
    super.debugLabel,
  });

  final _OriginalNestedScrollCoordinator coordinator;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _OriginalNestedScrollPosition(
      coordinator: coordinator,
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }

  @override
  void attach(ScrollPosition position) {
    assert(position is _OriginalNestedScrollPosition);
    super.attach(position);
    coordinator
      ..updateParent()
      ..updateCanDrag();
    position.addListener(_scheduleUpdateShadow);
    _scheduleUpdateShadow();
  }

  @override
  void detach(ScrollPosition position) {
    assert(position is _OriginalNestedScrollPosition);
    (position as _OriginalNestedScrollPosition).setParent(null);
    position.removeListener(_scheduleUpdateShadow);
    super.detach(position);
    _scheduleUpdateShadow();
  }

  void _scheduleUpdateShadow() {
    // We do this asynchronously for attach() so that the new position has had
    // time to be initialized, and we do it asynchronously for detach() and from
    // the position change notifications because those happen synchronously
    // during a frame, at a time where it's too late to call setState. Since the
    // result is usually animated, the lag incurred is no big deal.
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        coordinator.updateShadow();
      },
      // debugLabel: 'NestedScrollController.updateShadow',
    );
  }

  Iterable<_OriginalNestedScrollPosition> get nestedPositions {
    // use instance method version of castFrom when it is available.
    return Iterable.castFrom<ScrollPosition, _OriginalNestedScrollPosition>(
      positions,
    );
  }
}

// The _OriginalNestedScrollPosition is used by both the inner and outer viewports of a
// OriginalNestedScrollView. It tracks the offset to use for those viewports, and knows
// about the _OriginalNestedScrollCoordinator, so that when activities are triggered on
// this class, they can defer, or be influenced by, the coordinator.
class _OriginalNestedScrollPosition extends ScrollPosition implements ScrollActivityDelegate {
  _OriginalNestedScrollPosition({
    required super.physics,
    required super.context,
    required this.coordinator,
    double initialPixels = 0.0,
    super.oldPosition,
    super.debugLabel,
  }) {
    if (!hasPixels) {
      correctPixels(initialPixels);
    }
    if (activity == null) {
      goIdle();
    }
    assert(activity != null);
    saveScrollOffset(); // in case we didn't restore but could, so that we don't restore it later
  }

  final _OriginalNestedScrollCoordinator coordinator;

  TickerProvider get vsync => context.vsync;

  ScrollController? _parent;

  void setParent(ScrollController? value) {
    _parent?.detach(this);
    _parent = value;
    _parent?.attach(this);
  }

  @override
  AxisDirection get axisDirection => context.axisDirection;

  @override
  void absorb(ScrollPosition other) {
    super.absorb(other);
    activity!.updateDelegate(this);
  }

  @override
  void restoreScrollOffset() {
    if (coordinator.canScrollBody) {
      super.restoreScrollOffset();
    }
  }

  // Returns the amount of delta that was not used.
  //
  // Positive delta means going down (exposing stuff above), negative delta
  // going up (exposing stuff below).
  double applyClampedDragUpdate(double delta) {
    assert(delta != 0.0);
    // If we are going towards the maxScrollExtent (negative scroll offset),
    // then the furthest we can be in the minScrollExtent direction is negative
    // infinity. For example, if we are already overscrolled, then scrolling to
    // reduce the overscroll should not disallow the overscroll.
    //
    // If we are going towards the minScrollExtent (positive scroll offset),
    // then the furthest we can be in the minScrollExtent direction is wherever
    // we are now, if we are already overscrolled (in which case pixels is less
    // than the minScrollExtent), or the minScrollExtent if we are not.
    //
    // In other words, we cannot, via applyClampedDragUpdate, _enter_ an
    // overscroll situation.
    //
    // An overscroll situation might be nonetheless entered via several means.
    // One is if the physics allow it, via applyFullDragUpdate (see below). An
    // overscroll situation can also be forced, e.g. if the scroll position is
    // artificially set using the scroll controller.
    final min = delta < 0.0 ? -double.infinity : math.min(minScrollExtent, pixels);
    // The logic for max is equivalent but on the other side.
    final max = delta > 0.0
        ? double.infinity
        // If pixels < 0.0, then we are currently in overscroll. The max should be
        // 0.0, representing the end of the overscrolled portion.
        : pixels < 0.0
            ? 0.0
            : math.max(maxScrollExtent, pixels);
    final oldPixels = pixels;
    final newPixels = clampDouble(pixels - delta, min, max);
    final clampedDelta = newPixels - pixels;
    if (clampedDelta == 0.0) {
      return delta;
    }
    final overscroll = physics.applyBoundaryConditions(this, newPixels);
    final actualNewPixels = newPixels - overscroll;
    final offset = actualNewPixels - oldPixels;
    if (offset != 0.0) {
      forcePixels(actualNewPixels);
      didUpdateScrollPositionBy(offset);
    }

    return delta + offset;
  }

  // Returns the overscroll.
  double applyFullDragUpdate(double delta) {
    assert(delta != 0.0);
    final oldPixels = pixels;
    // Apply friction:
    final newPixels = pixels -
        physics.applyPhysicsToUserOffset(
          this,
          delta,
        );
    if ((oldPixels - newPixels).abs() < precisionErrorTolerance) {
      // Delta is so small we can drop it.
      return 0;
    }
    // Check for overscroll:
    final overscroll = physics.applyBoundaryConditions(this, newPixels);
    final actualNewPixels = newPixels - overscroll;
    if (actualNewPixels != oldPixels) {
      forcePixels(actualNewPixels);
      didUpdateScrollPositionBy(actualNewPixels - oldPixels);
    }
    if (overscroll != 0.0) {
      didOverscrollBy(overscroll);

      return overscroll;
    }

    return 0;
  }

  // Returns the amount of delta that was not used.
  //
  // Negative delta represents a forward ScrollDirection, while the positive
  // would be a reverse ScrollDirection.
  //
  // The method doesn't take into account the effects of [ScrollPhysics].
  double applyClampedPointerSignalUpdate(double delta) {
    assert(delta != 0.0);

    final min = delta > 0.0 ? -double.infinity : math.min(minScrollExtent, pixels);
    // The logic for max is equivalent but on the other side.
    final max = delta < 0.0 ? double.infinity : math.max(maxScrollExtent, pixels);
    final newPixels = clampDouble(pixels + delta, min, max);
    final clampedDelta = newPixels - pixels;
    if (clampedDelta == 0.0) {
      return delta;
    }
    forcePixels(newPixels);
    didUpdateScrollPositionBy(clampedDelta);

    return delta - clampedDelta;
  }

  @override
  ScrollDirection get userScrollDirection => coordinator.userScrollDirection;

  DrivenScrollActivity createDrivenScrollActivity(
    double to,
    Duration duration,
    Curve curve,
  ) {
    return DrivenScrollActivity(
      this,
      from: pixels,
      to: to,
      duration: duration,
      curve: curve,
      vsync: vsync,
    );
  }

  @override
  double applyUserOffset(double delta) {
    assert(false);

    return 0;
  }

  // This is called by activities when they finish their work.
  @override
  void goIdle() {
    beginActivity(IdleScrollActivity(this));
    coordinator.updateUserScrollDirection(ScrollDirection.idle);
  }

  // This is called by activities when they finish their work and want to go
  // ballistic.
  @override
  void goBallistic(double velocity) {
    Simulation? simulation;
    if (velocity != 0.0 || outOfRange) {
      simulation = physics.createBallisticSimulation(this, velocity);
    }
    beginActivity(
      createBallisticScrollActivity(
        simulation,
        mode: _OriginalNestedBallisticScrollActivityMode.independent,
      ),
    );
  }

  ScrollActivity createBallisticScrollActivity(
    Simulation? simulation, {
    required _OriginalNestedBallisticScrollActivityMode mode,
    _OriginalNestedScrollMetrics? metrics,
  }) {
    if (simulation == null) {
      return IdleScrollActivity(this);
    }
    switch (mode) {
      case _OriginalNestedBallisticScrollActivityMode.outer:
        assert(metrics != null);
        if (metrics!.minRange == metrics.maxRange) {
          return IdleScrollActivity(this);
        }
        return _OriginalNestedOuterBallisticScrollActivity(
          coordinator,
          this,
          metrics,
          simulation,
          context.vsync,
          activity?.shouldIgnorePointer ?? true,
        );
      case _OriginalNestedBallisticScrollActivityMode.inner:
        return _OriginalNestedInnerBallisticScrollActivity(
          coordinator,
          this,
          simulation,
          context.vsync,
          activity?.shouldIgnorePointer ?? true,
        );
      case _OriginalNestedBallisticScrollActivityMode.independent:
        return BallisticScrollActivity(
          this,
          simulation,
          context.vsync,
          activity?.shouldIgnorePointer ?? true,
        );
    }
  }

  @override
  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  }) {
    return coordinator.animateTo(
      coordinator.unnestOffset(to, this),
      duration: duration,
      curve: curve,
    );
  }

  @override
  void jumpTo(double value) {
    return coordinator.jumpTo(coordinator.unnestOffset(value, this));
  }

  @override
  void pointerScroll(double delta) {
    return coordinator.pointerScroll(delta);
  }

  @override
  void jumpToWithoutSettling(double value) {
    assert(false);
  }

  void localJumpTo(double value) {
    if (pixels != value) {
      final oldPixels = pixels;
      forcePixels(value);
      didStartScroll();
      didUpdateScrollPositionBy(pixels - oldPixels);
      didEndScroll();
    }
  }

  @override
  void applyNewDimensions() {
    super.applyNewDimensions();
    coordinator.updateCanDrag();
  }

  void updateCanDrag(bool innerCanDrag) {
    // This is only called for the outer position
    assert(coordinator._outerPosition == this);
    context.setCanDrag(
      // This refers to the physics of the actual outer scroll position, not
      // the whole NestedScrollView, since it is possible to have different
      // ScrollPhysics for the inner and outer positions.
      physics.shouldAcceptUserOffset(this) || innerCanDrag,
    );
  }

  @override
  ScrollHoldController hold(VoidCallback holdCancelCallback) {
    return coordinator.hold(holdCancelCallback);
  }

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    return coordinator.drag(details, dragCancelCallback);
  }
}

enum _OriginalNestedBallisticScrollActivityMode { outer, inner, independent }

class _OriginalNestedInnerBallisticScrollActivity extends BallisticScrollActivity {
  _OriginalNestedInnerBallisticScrollActivity(
    this.coordinator,
    super.delegate,
    super.simulation,
    super.vsync,
    super.shouldIgnorePointer,
  );

  final _OriginalNestedScrollCoordinator coordinator;

  @override
  _OriginalNestedScrollPosition get delegate => super.delegate as _OriginalNestedScrollPosition;

  @override
  void resetActivity() {
    delegate.beginActivity(
      coordinator.createInnerBallisticScrollActivity(
        delegate,
        velocity,
      ),
    );
  }

  @override
  void applyNewDimensions() {
    delegate.beginActivity(
      coordinator.createInnerBallisticScrollActivity(
        delegate,
        velocity,
      ),
    );
  }

  @override
  bool applyMoveTo(double value) {
    return super.applyMoveTo(coordinator.nestOffset(value, delegate));
  }
}

class _OriginalNestedOuterBallisticScrollActivity extends BallisticScrollActivity {
  _OriginalNestedOuterBallisticScrollActivity(
    this.coordinator,
    _OriginalNestedScrollPosition position,
    this.metrics,
    Simulation simulation,
    TickerProvider vsync,
    bool shouldIgnorePointer,
  )   : assert(metrics.minRange != metrics.maxRange),
        assert(metrics.maxRange > metrics.minRange),
        super(position, simulation, vsync, shouldIgnorePointer);

  final _OriginalNestedScrollCoordinator coordinator;
  final _OriginalNestedScrollMetrics metrics;

  @override
  _OriginalNestedScrollPosition get delegate => super.delegate as _OriginalNestedScrollPosition;

  @override
  void resetActivity() {
    delegate.beginActivity(
      coordinator.createOuterBallisticScrollActivity(velocity),
    );
  }

  @override
  void applyNewDimensions() {
    delegate.beginActivity(
      coordinator.createOuterBallisticScrollActivity(velocity),
    );
  }

  @override
  bool applyMoveTo(double value) {
    var done = false;
    var val = value;

    if (velocity > 0.0) {
      if (val < metrics.minRange) {
        return true;
      }
      if (val > metrics.maxRange) {
        val = metrics.maxRange;
        done = true;
      }
    } else if (velocity < 0.0) {
      if (val > metrics.maxRange) {
        return true;
      }
      if (val < metrics.minRange) {
        val = metrics.minRange;
        done = true;
      }
    } else {
      val = clampDouble(val, metrics.minRange, metrics.maxRange);
      done = true;
    }
    final result = super.applyMoveTo(val + metrics.correctionOffset);
    assert(
      result,
    ); // since we tried to pass an in-range value, it shouldn't ever overflow

    return !done;
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, '_OriginalNestedOuterBallisticScrollActivity')}(${metrics.minRange} .. ${metrics.maxRange}; correcting by ${metrics.correctionOffset})';
  }
}

/// Handle to provide to a [OriginalSliverOverlapAbsorber], a [OriginalSliverOverlapInjector],
/// and an [OriginalNestedScrollViewViewport], to shift overlap in a [OriginalNestedScrollView].
///
/// A particular [OriginalOverlapAbsorberHandle] can only be assigned to a single
/// [OriginalSliverOverlapAbsorber] at a time. It can also be (and normally is) assigned
/// to one or more [OriginalSliverOverlapInjector]s, which must be later descendants of
/// the same [OriginalNestedScrollViewViewport] as the [OriginalSliverOverlapAbsorber]. The
/// [OriginalSliverOverlapAbsorber] must be a direct descendant of the
/// [OriginalNestedScrollViewViewport], taking part in the same sliver layout. (The
/// [OriginalSliverOverlapInjector] can be a descendant that takes part in a nested
/// scroll view's sliver layout.)
///
/// Whenever the [OriginalNestedScrollViewViewport] is marked dirty for layout, it will
/// cause its assigned [OriginalOverlapAbsorberHandle] to fire notifications. It
/// is the responsibility of the [OriginalSliverOverlapInjector]s (and any other
/// clients) to mark themselves dirty when this happens, in case the geometry
/// subsequently changes during layout.
///
/// See also:
///
///  * [OriginalNestedScrollView], which uses a [OriginalNestedScrollViewViewport] and a
///    [OriginalSliverOverlapAbsorber] to align its children, and which shows sample
///    usage for this class.
class OriginalOverlapAbsorberHandle extends ChangeNotifier {
  /// Creates a [OriginalOverlapAbsorberHandle].
  OriginalOverlapAbsorberHandle() {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  // Incremented when a OriginalRenderSliverOverlapAbsorber takes ownership of this
  // object, decremented when it releases it. This allows us to find cases where
  // the same handle is being passed to two render objects.
  int _writers = 0;

  /// The current amount of overlap being absorbed by the
  /// [OriginalSliverOverlapAbsorber].
  ///
  /// This corresponds to the [SliverGeometry.layoutExtent] of the child of the
  /// [OriginalSliverOverlapAbsorber].
  ///
  /// This is updated during the layout of the [OriginalSliverOverlapAbsorber]. It
  /// should not change at any other time. No notifications are sent when it
  /// changes; clients (e.g. [OriginalSliverOverlapInjector]s) are responsible for
  /// marking themselves dirty whenever this object sends notifications, which
  /// happens any time the [OriginalSliverOverlapAbsorber] might subsequently change the
  /// value during that layout.
  double? get layoutExtent => _layoutExtent;
  double? _layoutExtent;

  /// The total scroll extent of the gap being absorbed by the
  /// [OriginalSliverOverlapAbsorber].
  ///
  /// This corresponds to the [SliverGeometry.scrollExtent] of the child of the
  /// [OriginalSliverOverlapAbsorber].
  ///
  /// This is updated during the layout of the [OriginalSliverOverlapAbsorber]. It
  /// should not change at any other time. No notifications are sent when it
  /// changes; clients (e.g. [OriginalSliverOverlapInjector]s) are responsible for
  /// marking themselves dirty whenever this object sends notifications, which
  /// happens any time the [OriginalSliverOverlapAbsorber] might subsequently change the
  /// value during that layout.
  double? get scrollExtent => _scrollExtent;
  double? _scrollExtent;

  void _setExtents(double? layoutValue, double? scrollValue) {
    assert(
      _writers == 1,
      'Multiple OriginalRenderSliverOverlapAbsorbers have been provided the same OriginalOverlapAbsorberHandle.',
    );
    _layoutExtent = layoutValue;
    _scrollExtent = scrollValue;
  }

  void _markNeedsLayout() => notifyListeners();

  @override
  String toString() {
    String? extra;
    switch (_writers) {
      case 0:
        extra = ', orphan';
      case 1:
        // normal case
        break;
      default:
        extra = ', $_writers WRITERS ASSIGNED';
        break;
    }

    return '${objectRuntimeType(this, 'OriginalOverlapAbsorberHandle')}($layoutExtent$extra)';
  }
}

/// A sliver that wraps another, forcing its layout extent to be treated as
/// overlap.
///
/// The difference between the overlap requested by the child `sliver` and the
/// overlap reported by this widget, called the _absorbed overlap_, is reported
/// to the [OriginalOverlapAbsorberHandle], which is typically passed to a
/// [OriginalSliverOverlapInjector].
///
/// See also:
///
///  * [OriginalNestedScrollView], whose documentation has sample code showing how to
///    use this widget.
class OriginalSliverOverlapAbsorber extends SingleChildRenderObjectWidget {
  /// Creates a sliver that absorbs overlap and reports it to a
  /// [OriginalOverlapAbsorberHandle].
  const OriginalSliverOverlapAbsorber({
    required this.handle,
    super.key,
    Widget? sliver,
  }) : super(child: sliver);

  /// The object in which the absorbed overlap is recorded.
  ///
  /// A particular [OriginalOverlapAbsorberHandle] can only be assigned to a
  /// single [OriginalSliverOverlapAbsorber] at a time.
  final OriginalOverlapAbsorberHandle handle;

  @override
  OriginalRenderSliverOverlapAbsorber createRenderObject(BuildContext context) {
    return OriginalRenderSliverOverlapAbsorber(
      handle: handle,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    OriginalRenderSliverOverlapAbsorber renderObject,
  ) {
    renderObject.handle = handle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<OriginalOverlapAbsorberHandle>('handle', handle),
    );
  }
}

/// A sliver that wraps another, forcing its layout extent to be treated as
/// overlap.
///
/// The difference between the overlap requested by the child `sliver` and the
/// overlap reported by this widget, called the _absorbed overlap_, is reported
/// to the [OriginalOverlapAbsorberHandle], which is typically passed to a
/// [OriginalRenderSliverOverlapInjector].
class OriginalRenderSliverOverlapAbsorber extends RenderSliver with RenderObjectWithChildMixin<RenderSliver> {
  /// Create a sliver that absorbs overlap and reports it to a
  /// [OriginalOverlapAbsorberHandle].
  ///
  /// The [sliver] must be a [RenderSliver].
  OriginalRenderSliverOverlapAbsorber({
    required OriginalOverlapAbsorberHandle handle,
    RenderSliver? sliver,
  }) : _handle = handle {
    child = sliver;
  }

  /// The object in which the absorbed overlap is recorded.
  ///
  /// A particular [OriginalOverlapAbsorberHandle] can only be assigned to a
  /// single [OriginalRenderSliverOverlapAbsorber] at a time.
  OriginalOverlapAbsorberHandle get handle => _handle;
  OriginalOverlapAbsorberHandle _handle;
  set handle(OriginalOverlapAbsorberHandle value) {
    if (handle == value) {
      return;
    }
    if (attached) {
      handle._writers -= 1;
      value
        .._writers += 1
        .._setExtents(handle.layoutExtent, handle.scrollExtent);
    }
    _handle = value;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    handle._writers += 1;
  }

  @override
  void detach() {
    handle._writers -= 1;
    super.detach();
  }

  @override
  void performLayout() {
    assert(
      handle._writers == 1,
      'A OriginalOverlapAbsorberHandle cannot be passed to multiple OriginalRenderSliverOverlapAbsorber objects at the same time.',
    );
    if (child == null) {
      geometry = SliverGeometry.zero;

      return;
    }
    child!.layout(constraints, parentUsesSize: true);
    final childLayoutGeometry = child!.geometry!;
    geometry = childLayoutGeometry.copyWith(
      scrollExtent: childLayoutGeometry.scrollExtent - childLayoutGeometry.maxScrollObstructionExtent,
      layoutExtent: math.max(
        0,
        childLayoutGeometry.paintExtent - childLayoutGeometry.maxScrollObstructionExtent,
      ),
    );
    handle._setExtents(
      childLayoutGeometry.maxScrollObstructionExtent,
      childLayoutGeometry.maxScrollObstructionExtent,
    );
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    // child is always at our origin
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    if (child != null) {
      return child!.hitTest(
        result,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition,
      );
    }

    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<OriginalOverlapAbsorberHandle>('handle', handle),
    );
  }
}

/// A sliver that has a sliver geometry based on the values stored in a
/// [OriginalOverlapAbsorberHandle].
///
/// The [OriginalSliverOverlapAbsorber] must be an earlier descendant of a common
/// ancestor [Viewport], so that it will always be laid out before the
/// [OriginalSliverOverlapInjector] during a particular frame.
///
/// See also:
///
///  * [OriginalNestedScrollView], which uses a [OriginalSliverOverlapAbsorber] to align its
///    children, and which shows sample usage for this class.
class OriginalSliverOverlapInjector extends SingleChildRenderObjectWidget {
  /// Creates a sliver that is as tall as the value of the given [handle]'s
  /// layout extent.
  const OriginalSliverOverlapInjector({
    required this.handle,
    super.key,
    Widget? sliver,
  }) : super(child: sliver);

  /// The handle to the [OriginalSliverOverlapAbsorber] that is feeding this injector.
  ///
  /// This should be a handle owned by a [OriginalSliverOverlapAbsorber] and a
  /// [OriginalNestedScrollViewViewport].
  final OriginalOverlapAbsorberHandle handle;

  @override
  OriginalRenderSliverOverlapInjector createRenderObject(BuildContext context) {
    return OriginalRenderSliverOverlapInjector(
      handle: handle,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    OriginalRenderSliverOverlapInjector renderObject,
  ) {
    renderObject.handle = handle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<OriginalOverlapAbsorberHandle>('handle', handle),
    );
  }
}

/// A sliver that has a sliver geometry based on the values stored in a
/// [OriginalOverlapAbsorberHandle].
///
/// The [OriginalRenderSliverOverlapAbsorber] must be an earlier descendant of a common
/// ancestor [RenderViewport] (probably a [OriginalRenderNestedScrollViewViewport]), so
/// that it will always be laid out before the [OriginalRenderSliverOverlapInjector]
/// during a particular frame.
class OriginalRenderSliverOverlapInjector extends RenderSliver {
  /// Creates a sliver that is as tall as the value of the given [handle]'s extent.
  OriginalRenderSliverOverlapInjector({
    required OriginalOverlapAbsorberHandle handle,
  }) : _handle = handle;

  double? _currentLayoutExtent;
  double? _currentMaxExtent;

  /// The object that specifies how wide to make the gap injected by this render
  /// object.
  ///
  /// This should be a handle owned by a [OriginalRenderSliverOverlapAbsorber] and a
  /// [OriginalRenderNestedScrollViewViewport].
  OriginalOverlapAbsorberHandle get handle => _handle;
  OriginalOverlapAbsorberHandle _handle;
  set handle(OriginalOverlapAbsorberHandle value) {
    if (handle == value) {
      return;
    }
    if (attached) {
      handle.removeListener(markNeedsLayout);
    }
    _handle = value;
    if (attached) {
      handle.addListener(markNeedsLayout);
      if (handle.layoutExtent != _currentLayoutExtent || handle.scrollExtent != _currentMaxExtent) {
        markNeedsLayout();
      }
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    handle.addListener(markNeedsLayout);
    if (handle.layoutExtent != _currentLayoutExtent || handle.scrollExtent != _currentMaxExtent) {
      markNeedsLayout();
    }
  }

  @override
  void detach() {
    handle.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void performLayout() {
    _currentLayoutExtent = handle.layoutExtent;
    _currentMaxExtent = handle.layoutExtent;
    assert(
        _currentLayoutExtent != null && _currentMaxExtent != null,
        'SliverOverlapInjector has found no absorbed extent to inject.\n '
        'The SliverOverlapAbsorber must be an earlier descendant of a common '
        'ancestor Viewport, so that it will always be laid out before the '
        'SliverOverlapInjector during a particular frame.\n '
        'The SliverOverlapAbsorber is typically contained in the list of slivers '
        'provided by NestedScrollView.headerSliverBuilder.\n');
    final double clampedLayoutExtent = math.min(
      _currentLayoutExtent! - constraints.scrollOffset,
      constraints.remainingPaintExtent,
    );
    geometry = SliverGeometry(
      scrollExtent: _currentLayoutExtent!,
      paintExtent: math.max(0, clampedLayoutExtent),
      maxPaintExtent: _currentMaxExtent!,
    );
  }

  @override
  void debugPaint(PaintingContext context, Offset offset) {
    assert(() {
      if (debugPaintSizeEnabled) {
        final paint = Paint()
          ..color = const Color(0xFFCC9933)
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke;
        Offset start;
        Offset end;
        Offset delta;
        switch (constraints.axis) {
          case Axis.vertical:
            final x = offset.dx + constraints.crossAxisExtent / 2.0;
            start = Offset(x, offset.dy);
            end = Offset(x, offset.dy + geometry!.paintExtent);
            delta = Offset(constraints.crossAxisExtent / 5.0, 0);
          case Axis.horizontal:
            final y = offset.dy + constraints.crossAxisExtent / 2.0;
            start = Offset(offset.dx, y);
            end = Offset(offset.dy + geometry!.paintExtent, y);
            delta = Offset(0, constraints.crossAxisExtent / 5.0);
        }
        for (var index = -2; index <= 2; index += 1) {
          paintZigZag(
            context.canvas,
            paint,
            start - delta * index.toDouble(),
            end - delta * index.toDouble(),
            10,
            10,
          );
        }
      }

      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<OriginalOverlapAbsorberHandle>('handle', handle),
    );
  }
}

/// The [Viewport] variant used by [OriginalNestedScrollView].
///
/// This viewport takes a [OriginalOverlapAbsorberHandle] and notifies it any time
/// the viewport needs to recompute its layout (e.g. when it is scrolled).
class OriginalNestedScrollViewViewport extends Viewport {
  /// Creates a variant of [Viewport] that has a [OriginalOverlapAbsorberHandle].
  OriginalNestedScrollViewViewport({
    required super.offset,
    required this.handle,
    super.key,
    super.axisDirection,
    super.crossAxisDirection,
    super.anchor,
    super.center,
    super.slivers,
    super.clipBehavior,
  });

  /// The handle to the [OriginalSliverOverlapAbsorber] that is feeding this injector.
  final OriginalOverlapAbsorberHandle handle;

  @override
  OriginalRenderNestedScrollViewViewport createRenderObject(
    BuildContext context,
  ) {
    return OriginalRenderNestedScrollViewViewport(
      axisDirection: axisDirection,
      crossAxisDirection: crossAxisDirection ??
          Viewport.getDefaultCrossAxisDirection(
            context,
            axisDirection,
          ),
      anchor: anchor,
      offset: offset,
      handle: handle,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    OriginalRenderNestedScrollViewViewport renderObject,
  ) {
    renderObject
      ..axisDirection = axisDirection
      ..crossAxisDirection = crossAxisDirection ??
          Viewport.getDefaultCrossAxisDirection(
            context,
            axisDirection,
          )
      ..anchor = anchor
      ..offset = offset
      ..handle = handle
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<OriginalOverlapAbsorberHandle>('handle', handle),
    );
  }
}

/// The [RenderViewport] variant used by [OriginalNestedScrollView].
///
/// This viewport takes a [OriginalOverlapAbsorberHandle] and notifies it any time
/// the viewport needs to recompute its layout (e.g. when it is scrolled).
class OriginalRenderNestedScrollViewViewport extends RenderViewport {
  /// Create a variant of [RenderViewport] that has a
  /// [OriginalOverlapAbsorberHandle].
  OriginalRenderNestedScrollViewViewport({
    required super.crossAxisDirection,
    required super.offset,
    required OriginalOverlapAbsorberHandle handle,
    super.axisDirection,
    super.anchor,
    super.children,
    super.center,
    super.clipBehavior,
  }) : _handle = handle;

  /// The object to notify when [markNeedsLayout] is called.
  OriginalOverlapAbsorberHandle get handle => _handle;
  OriginalOverlapAbsorberHandle _handle;

  /// Setting this will trigger notifications on the new object.
  set handle(OriginalOverlapAbsorberHandle value) {
    if (handle == value) {
      return;
    }
    _handle = value;
    handle._markNeedsLayout();
  }

  @override
  void markNeedsLayout() {
    handle._markNeedsLayout();
    super.markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<OriginalOverlapAbsorberHandle>('handle', handle),
    );
  }
}
