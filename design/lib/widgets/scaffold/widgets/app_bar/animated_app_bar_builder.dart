// ignore_for_file: max_lines_for_file, max_lines_for_function, invalid_use_of_protected_member, avoid_empty_blocks, avoid_nested_if, avoid_print
import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../models/fab_appbar_search_bar_settings.dart';
import '../../models/fab_appbar_settings.dart';
import '../../utils/measures.dart';
import '../../utils/store.dart';
import '../linked_scroll_controller.dart';
import 'animated_app_bar.dart';

class AnimatedAppBarBuilder extends StatefulWidget {
  const AnimatedAppBarBuilder({
    required this.keys,
    required this.components,
    required this.syncScrollController,
    required this.appBarSettings,
    required this.measures,
    required this.shouldTransiteBetweenRoutes,
    this.onCollapsed,
    super.key,
  });

  final NavigationBarStaticComponentsKeys keys;
  final NavigationBarStaticComponents components;
  final FabAppBarSettings appBarSettings;
  final Measures measures;
  final ValueChanged<bool>? onCollapsed;
  final bool shouldTransiteBetweenRoutes;
  final LinkedScrollControllerGroup syncScrollController;

  @override
  State<AnimatedAppBarBuilder> createState() => _AnimatedAppBarBuilderState();
}

class _AnimatedAppBarBuilderState extends State<AnimatedAppBarBuilder> with TickerProviderStateMixin {
  late final Animation _animation;
  late final AnimationController _animationController;
  late final TextEditingController _editingController;
  late final FocusNode _focusNode;

  double _offset = 0;
  bool _isCollapsed = false;

  @override
  void dispose() {
    _editingController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    widget.syncScrollController.removeOffsetChangedListener(_scrollListener);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _editingController = widget.appBarSettings.searchBar!.searchController ?? TextEditingController();
    _focusNode = widget.appBarSettings.searchBar!.searchFocusNode ?? FocusNode();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = ColorTween(
      begin: $.theme.appBarExpandedColor,
      end: $.theme.appBarCollapsedColor.withOpacity(widget.appBarSettings.hasBackgroundBlur ? 0.5 : 1),
    ).animate(CurvedAnimation(curve: Curves.linear, parent: _animationController))
      ..addListener(() {
        setState(() {});
      });

    widget.syncScrollController.addOffsetChangedListener(_scrollListener);
  }

  Store get _store => Store.instance();

  void _scrollListener() {
    final scrollOffset = widget.syncScrollController.offset;

    _offset = scrollOffset;
    _store.offset.value = scrollOffset;

    _checkIfCollapsed(scrollOffset);
/*     _store.calculate(scrollOffset, measures: widget.measures, settings: widget.appBarSettings); */
/*     setState(() {}); */
  }

  void _checkIfCollapsed(double scrollOffset) {
    final searchBar = widget.appBarSettings.searchBar;
    final scrollBehavior = searchBar!.scrollBehavior;
    final titleFadeOutPadding = widget.measures.getTitleFadeOutPadding;

    var isCollapsed = false;

    if (scrollBehavior == SearchBarScrollBehavior.floated) {
      isCollapsed =
          scrollOffset >= widget.measures.largeTitleHeight + widget.measures.getSearchBarHeight - titleFadeOutPadding;
    } else {
      isCollapsed = scrollOffset >= widget.measures.largeTitleHeight - titleFadeOutPadding;
    }

    if (_isCollapsed != isCollapsed) {
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
      valueListenable: _store.offset,
      builder: (_, __, ___) {
        _store.calculate(
          _offset,
          measures: widget.measures,
          settings: widget.appBarSettings,
        );

        return AnimatedAppBar(
          measures: widget.measures,
          animationController: _animationController,
          appBarSettings: widget.appBarSettings,
          components: widget.components,
          editingController: _editingController,
          focusNode: _focusNode,
          keys: widget.keys,
          isCollapsed: _isCollapsed,
          shouldTransiteBetweenRoutes: widget.shouldTransiteBetweenRoutes,
          color: _animation.value,
        );
      },
    );
  }
}
