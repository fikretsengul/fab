// ignore_for_file: max_lines_for_file, max_lines_for_function
import 'dart:ui';

import 'package:deps/packages/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../_core/constants/app_theme.dart';
import '../../models/appbar_search_bar_settings.dart';
import '../../models/appbar_settings.dart';
import '../../utils/measures.dart';
import '../../utils/store.dart';
import '../transitionable_navigation_bar.dart';
import 'animated_app_bar.dart';

class AnimatedAppBarBuilder extends StatefulWidget {
  const AnimatedAppBarBuilder({
    required this.measures,
    required this.appBar,
    required this.components,
    required this.keys,
    required this.topPadding,
    required this.shouldStretch,
    required this.shouldTransiteBetweenRoutes,
    required this.scrollController,
    required this.refreshListenable,
    required this.isScrollEnabled,
    this.onCollapsed,
    this.brightness,
    super.key,
  });

  final AppBarSettings appBar;
  final Brightness? brightness;
  final NavigationBarStaticComponents components;
  final ValueNotifier<bool> isScrollEnabled;
  final NavigationBarStaticComponentsKeys keys;
  final Measures measures;
  final ValueChanged<bool>? onCollapsed;
  final IndicatorStateListenable refreshListenable;
  final ScrollController scrollController;
  final bool shouldStretch;
  final bool shouldTransiteBetweenRoutes;
  final double topPadding;

  @override
  State<AnimatedAppBarBuilder> createState() => _AnimatedAppBarBuilderState();
}

class _AnimatedAppBarBuilderState extends State<AnimatedAppBarBuilder> with TickerProviderStateMixin {
  late final TextEditingController _editingController;
  late final FocusNode _focusNode;
  bool _isCollapsed = false;
  double _scrollOffset = 0;

  late AnimationController _animationController;
  late Animation _animation;

  Color _expandedColor(BuildContext context) => context.appTheme.appBarExpanded;
  Color _collapsedColor(BuildContext context) =>
      context.appTheme.appBarCollapsed.withOpacity(widget.appBar.hasBackgroundBlur ? 0.5 : 1);

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    _editingController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _editingController = widget.appBar.searchBar!.searchController ?? TextEditingController();
    _focusNode = widget.appBar.searchBar!.searchFocusNode ?? FocusNode();
  }

  @override
  void didChangeDependencies() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = ColorTween(
      begin: _expandedColor(context),
      end: _collapsedColor(context),
    ).animate(CurvedAnimation(curve: Curves.linear, parent: _animationController))
      ..addListener(() {
        setState(() {});
      });
    super.didChangeDependencies();
  }

  void _scrollListener() {
    _scrollOffset = widget.scrollController.offset;
    _store.scrollOffset.value = widget.scrollController.offset;
    _checkIfCollapsed();
  }

  Store get _store => Store.instance();

  void _checkIfCollapsed() {
    final searchBar = widget.appBar.searchBar!;
    final scrollBehavior = searchBar.scrollBehavior;

    var isCollapsed = false;

    if (scrollBehavior == SearchBarScrollBehavior.floated) {
      isCollapsed =
          _scrollOffset >= widget.measures.largeTitleContainerHeight + widget.measures.searchContainerHeight - 20;
    } else {
      isCollapsed = _scrollOffset >= widget.measures.largeTitleContainerHeight - 20;
    }

    if (_isCollapsed != isCollapsed) {
      if (widget.onCollapsed != null) {
        widget.onCollapsed?.call(isCollapsed);
      }
      _isCollapsed = isCollapsed;

      if (_isCollapsed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.isScrollEnabled,
      builder: (_, isContentScrollable, __) {
        if (isContentScrollable) {
          widget.scrollController.addListener(_scrollListener);
        }

        return ValueListenableBuilder(
          valueListenable: _store.scrollOffset,
          builder: (_, __, ___) {
            var fullAppBarHeight = widget.appBar.searchBar!.scrollBehavior == SearchBarScrollBehavior.floated
                ? clampDouble(
                    widget.topPadding + widget.measures.appbarHeight - _scrollOffset,
                    widget.topPadding + widget.measures.primaryToolbarHeight + widget.appBar.bottom!.height,
                    widget.shouldStretch ? 3000 : widget.topPadding + widget.measures.appbarHeight,
                  )
                : clampDouble(
                    widget.topPadding + widget.measures.appbarHeight - _scrollOffset,
                    widget.topPadding + widget.measures.appbarHeight - widget.measures.largeTitleContainerHeight,
                    widget.shouldStretch ? 3000 : widget.topPadding + widget.measures.appbarHeight,
                  );

            var largeTitleHeight = widget.appBar.searchBar!.scrollBehavior == SearchBarScrollBehavior.floated
                ? (_scrollOffset > widget.measures.searchContainerHeight
                    ? clampDouble(
                        widget.measures.largeTitleContainerHeight -
                            (_scrollOffset - widget.measures.searchContainerHeight),
                        0,
                        widget.measures.largeTitleContainerHeight,
                      )
                    : widget.measures.largeTitleContainerHeight)
                : clampDouble(
                    widget.measures.largeTitleContainerHeight - _scrollOffset,
                    0,
                    widget.measures.largeTitleContainerHeight,
                  );

            final searchBarHeight = widget.appBar.searchBar!.scrollBehavior == SearchBarScrollBehavior.floated
                ? (_store.searchBarHasFocus.value
                    ? widget.measures.searchContainerHeight
                    : clampDouble(
                        widget.measures.searchContainerHeight - _scrollOffset,
                        0,
                        widget.measures.searchContainerHeight,
                      ))
                : widget.measures.searchContainerHeight;

            var opacity = widget.appBar.searchBar!.scrollBehavior == SearchBarScrollBehavior.floated
                ? (_store.searchBarHasFocus.value ? 1.0 : clampDouble(1 - _scrollOffset / 10.0, 0, 1))
                : 1.0;

            var titleOpacity = widget.appBar.searchBar!.scrollBehavior == SearchBarScrollBehavior.floated
                ? (_scrollOffset >=
                        (widget.measures.appbarHeightExceptPrimaryToolbar - widget.appBar.bottom!.height - 20)
                    ? 1.0
                    : (widget.measures.largeTitleContainerHeight > 0.0 ? 0.0 : 1.0))
                : (_scrollOffset >= (widget.measures.largeTitleContainerHeight - 20)
                    ? 1.0
                    : (widget.measures.largeTitleContainerHeight > 0.0 ? 0.0 : 1.0));

            final focussedToolbar =
                widget.topPadding + widget.measures.searchContainerHeight + widget.appBar.bottom!.height;

            var scaleTitle = _scrollOffset < 0 ? clampDouble(1 - _scrollOffset / 1500, 1, 1.12) : 1.0;

            if (widget.appBar.searchBar!.animationBehavior == SearchBarAnimationBehavior.steady &&
                _store.searchBarHasFocus.value) {
              fullAppBarHeight = widget.topPadding + widget.measures.appbarHeight;
              largeTitleHeight = widget.measures.appbarHeightExceptPrimaryToolbar;
              largeTitleHeight = widget.measures.largeTitleContainerHeight;
              scaleTitle = 1;
              titleOpacity = 0;
            }

            if (!widget.shouldStretch) {
              scaleTitle = 1;
            }
            if (widget.appBar.alwaysShowTitle) {
              titleOpacity = 1;
            }
            if (!widget.appBar.searchBar!.enabled) {
              opacity = 0;
            }

            return AnimatedAppBar(
              measures: widget.measures,
              appBar: widget.appBar,
              largeTitleHeight: largeTitleHeight,
              scaleTitle: scaleTitle,
              components: widget.components,
              searchBarHeight: searchBarHeight,
              opacity: opacity,
              titleOpacity: titleOpacity,
              editingController: _editingController,
              focusNode: _focusNode,
              keys: widget.keys,
              fullAppBarHeight: fullAppBarHeight,
              focussedToolbar: focussedToolbar,
              isCollapsed: _isCollapsed,
              topPadding: widget.topPadding,
              shouldTransiteBetweenRoutes: widget.shouldTransiteBetweenRoutes,
              refreshListenable: widget.refreshListenable,
              brightness: widget.brightness,
              color: _animation.value,
            );
          },
        );
      },
    );
  }
}
