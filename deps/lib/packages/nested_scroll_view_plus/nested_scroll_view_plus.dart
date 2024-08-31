part of 'nested_scroll_view.dart';

enum OverscrollBehavior {
  ///allow inner scroller to overscroll
  inner,

  ///allow outer scroller to overscroll
  outer,
}

class NestedScrollViewPlus extends StatelessWidget {
  /// An enhanced `NestedScrollView` offering overscroll support for both the nested and parent scroll views, ensuring a seamless scrolling experience.
  ///
  /// 🔥 Usage example:
  ///
  /// ```dart
  /// // Step 1: Replace `NestedScrollView` with `NestedScrollViewPlus`
  /// NestedScrollViewPlus(
  ///   headerSliverBuilder: (context, innerScrolled) => <Widget>[
  ///     // ... insert your header sliver widgets here
  ///   ],
  ///   body: CustomScrollView(
  ///     // Step 2: [🚨IMPORTANT] Set the physics of `CustomScrollView` to `AlwaysScrollableScrollPhysics`
  ///     physics: const BouncingScrollPhysics(
  ///       parent: AlwaysScrollableScrollPhysics(),
  ///     ),
  ///     slivers: <Widget>[
  ///       // ... insert your body sliver widgets here
  ///     ],
  ///   ),
  /// );
  /// ```
  ///
  /// Note: Floating header slivers are not supported.
  ///
  // ignore: use_key_in_widget_constructors
  const NestedScrollViewPlus({
    required this.headerSliverBuilder,
    required this.body,
    Key? key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    // this.floatHeaderSlivers = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scrollBehavior,
    this.overscrollBehavior = OverscrollBehavior.outer,
    this.pushPinnedHeaderSlivers = false,
  }) : _key = key;

  final Key? _key;
  final ScrollController? controller;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final OriginalNestedScrollViewHeaderSliversBuilder headerSliverBuilder;
  final Widget body;
  // final bool floatHeaderSlivers;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollBehavior? scrollBehavior;

  final OverscrollBehavior overscrollBehavior;

  /// If true any header sliver that paint beyond the layoutExtent of the entire outer scroll view will
  /// be pushed off towards the leading edge of the outer scroll view.
  final bool pushPinnedHeaderSlivers;

  @override
  Widget build(BuildContext context) {
    return overscrollBehavior == OverscrollBehavior.outer
        ? NestedScrollViewOuter(
            key: _key,
            controller: controller,
            scrollDirection: scrollDirection,
            reverse: reverse,
            physics: physics,
            headerSliverBuilder: headerSliverBuilder,
            body: body,
            dragStartBehavior: dragStartBehavior,
            clipBehavior: clipBehavior,
            restorationId: restorationId,
            scrollBehavior: scrollBehavior,
            pushPinnedHeaderSlivers: pushPinnedHeaderSlivers,
          )
        : NestedScrollViewInner(
            key: _key,
            controller: controller,
            scrollDirection: scrollDirection,
            reverse: reverse,
            physics: physics,
            headerSliverBuilder: headerSliverBuilder,
            body: body,
            dragStartBehavior: dragStartBehavior,
            clipBehavior: clipBehavior,
            restorationId: restorationId,
            scrollBehavior: scrollBehavior,
            pushPinnedHeaderSlivers: pushPinnedHeaderSlivers,
          );
  }

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
}

@Deprecated(
  'As of version 2.0, wrapping child components with this widget is no longer required. Please remove the wrap from your child components',
)
class SliverOverlapAbsorberPlus extends OriginalSliverOverlapAbsorber {
  const SliverOverlapAbsorberPlus({
    required super.handle,
    super.key,
    super.sliver,
    OverscrollBehavior overscrollBehavior = OverscrollBehavior.outer,
  }) : _overscrollBehavior = overscrollBehavior;

  final OverscrollBehavior _overscrollBehavior;

  @override
  OriginalRenderSliverOverlapAbsorber createRenderObject(BuildContext context) {
    return _overscrollBehavior == OverscrollBehavior.outer
        ? RenderSliverOverlapAbsorberOuter(handle: handle)
        : RenderSliverOverlapAbsorberInner(handle: handle);
  }
}

@Deprecated(
  'As of version 2.0, wrapping child components with this widget is no longer required. Please remove the wrap from your child components',
)
class OverlapAbsorberPlus extends StatelessWidget {
  const OverlapAbsorberPlus({
    super.key,
    this.sliver,
    this.overscrollBehavior = OverscrollBehavior.outer,
  });

  final Widget? sliver;
  final OverscrollBehavior overscrollBehavior;

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorberPlus(
      overscrollBehavior: overscrollBehavior,
      handle: NestedScrollViewPlus.sliverOverlapAbsorberHandleFor(
        context,
      ),
      sliver: sliver,
    );
  }
}

@Deprecated(
  'No longer needed as of v2.0. Remove the Injector widget from atop your scroll views.',
)
class SliverOverlapInjectorPlus extends OriginalSliverOverlapInjector {
  const SliverOverlapInjectorPlus({
    required super.handle,
    super.key,
    super.sliver,
    OverscrollBehavior overscrollBehavior = OverscrollBehavior.outer,
  }) : _overscrollBehavior = overscrollBehavior;

  final OverscrollBehavior _overscrollBehavior;

  @override
  OriginalRenderSliverOverlapInjector createRenderObject(BuildContext context) {
    return _overscrollBehavior == OverscrollBehavior.outer
        ? RenderSliverOverlapInjectorOuter(handle: handle)
        : RenderSliverOverlapInjectorInner(handle: handle);
  }
}

@Deprecated(
  'No longer needed as of v2.0. Remove the Injector widget from atop your scroll views.',
)
class OverlapInjectorPlus extends StatelessWidget {
  const OverlapInjectorPlus({
    super.key,
    this.overscrollBehavior = OverscrollBehavior.outer,
  });

  final OverscrollBehavior overscrollBehavior;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => SliverOverlapInjectorPlus(
        overscrollBehavior: overscrollBehavior,
        handle: NestedScrollViewPlus.sliverOverlapAbsorberHandleFor(context),
      ),
    );
  }
}
