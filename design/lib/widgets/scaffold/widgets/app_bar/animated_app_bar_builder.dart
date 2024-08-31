// ignore_for_file: max_lines_for_file, max_lines_for_function, invalid_use_of_protected_member, avoid_empty_blocks, avoid_nested_if, avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../_core/constants/fab_theme.dart';
import '../../../_core/overridens/overriden_transitionable_navigation_bar.dart';
import '../../models/fab_appbar_search_bar_settings.dart';
import '../../models/fab_appbar_settings.dart';
import '../../utils/helpers.dart';
import '../../utils/measures.dart';
import '../../utils/store.dart';
import '../linked_scroll_controller.dart';
import 'animated_app_bar.dart';

class AnimatedAppBarBuilder extends StatefulWidget {
  const AnimatedAppBarBuilder({
    required this.syncScrollController,
    required this.appBarSettings,
    required this.measures,
    required this.shouldTransiteBetweenRoutes,
    this.onCollapsed,
    super.key,
  });

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
  late final NavigationBarStaticComponents _components;
  late final TextEditingController _editingController;
  late final FocusNode _focusNode;
  bool _isCollapsed = false;
  late final NavigationBarStaticComponentsKeys _keys;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = ColorTween(
      begin: _expandedColor(context),
      end: _collapsedColor(context),
    ).animate(CurvedAnimation(curve: Curves.linear, parent: _animationController))
      ..addListener(() {
        setState(() {});
      });
    _components = _configureComponents();
  }

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
    _editingController = widget.appBarSettings.searchBar.searchController ?? TextEditingController();
    _focusNode = widget.appBarSettings.searchBar.searchFocusNode ?? FocusNode();
    _keys = NavigationBarStaticComponentsKeys();
    widget.syncScrollController.addOffsetChangedListener(_scrollListener);
  }

  NavigationBarStaticComponents _configureComponents() {
    final smallTitle = widget.appBarSettings.title is Text
        ? Text(
            '${(widget.appBarSettings.title! as Text).data}',
            style: defaultTitleTextStyle(context, widget.appBarSettings),
          )
        : widget.appBarSettings.title;

    return NavigationBarStaticComponents(
      keys: _keys,
      route: ModalRoute.of(context),
      userLeading: widget.appBarSettings.leading,
      automaticallyImplyLeading: widget.appBarSettings.automaticallyImplyLeading,
      automaticallyImplyTitle: true,
      previousPageTitle: widget.appBarSettings.previousPageTitle,
      userMiddle: smallTitle,
      userTrailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [...widget.appBarSettings.actions],
        ),
      ),
      largeTitleActions: Row(
        children: [
          ...?widget.appBarSettings.largeTitle.actions,
        ],
      ),
      userLargeTitle: Text(
        widget.appBarSettings.largeTitle.text,
        style: context.fabTheme.appBarLargeTitleStyle.copyWith(inherit: false),
        overflow: TextOverflow.ellipsis,
      ),
      appbarBottom: widget.appBarSettings.toolbar.child,
      padding: null,
      large: true,
    );
  }

  Color _expandedColor(BuildContext context) => context.fabTheme.appBarExpandedColor;

  Color _collapsedColor(BuildContext context) =>
      context.fabTheme.appBarCollapsedColor.withOpacity(widget.appBarSettings.hasBackgroundBlur ? 0.5 : 1);

  Store get _store => Store.instance();

  void _scrollListener() {
    final scrollOffset = widget.syncScrollController.offset;
    print(scrollOffset);
    _checkIfCollapsed(scrollOffset);
    _store.calculate(scrollOffset, measures: widget.measures, settings: widget.appBarSettings);
    setState(() {});
  }

  void _checkIfCollapsed(double scrollOffset) {
    final searchBar = widget.appBarSettings.searchBar;
    final scrollBehavior = searchBar.scrollBehavior;

    var isCollapsed = false;

    if (scrollBehavior == SearchBarScrollBehavior.floated) {
      isCollapsed = scrollOffset >= widget.measures.largeTitleHeight + widget.measures.getSearchBarHeight - 20;
    } else {
      isCollapsed = scrollOffset >= widget.measures.largeTitleHeight - 20;
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
    return AnimatedAppBar(
      measures: widget.measures,
      animationController: _animationController,
      appBarSettings: widget.appBarSettings,
      components: _components,
      editingController: _editingController,
      focusNode: _focusNode,
      keys: _keys,
      isCollapsed: _isCollapsed,
      shouldTransiteBetweenRoutes: widget.shouldTransiteBetweenRoutes,
      color: _animation.value,
    );
  }
}
