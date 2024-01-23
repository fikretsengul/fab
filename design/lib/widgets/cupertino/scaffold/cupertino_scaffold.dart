// ignore_for_file: avoid_returning_widgets, max_lines_for_file

import 'dart:async';

import 'package:deps/packages/easy_refresh.dart';
import 'package:deps/packages/nested_scroll_view_plus.dart';
import 'package:flutter/cupertino.dart';

import 'models/appbar_settings.dart';
import 'utils/helpers.dart';
import 'utils/measures.dart';
import 'utils/store.dart';
import 'widgets/app_bar/animated_app_bar_builder.dart';
import 'widgets/app_bar/search_bar/search_bar_result.dart';
import 'widgets/body.dart';
import 'widgets/refresher.dart';
import 'widgets/transitionable_navigation_bar.dart';

class CupertinoScaffold extends StatefulWidget {
  CupertinoScaffold({
    required this.body,
    required this.appBar,
    this.brightness,
    super.key,
    this.shouldStretch = true,
    this.onCollapsed,
    this.scrollController,
    this.shouldTransiteBetweenRoutes = true,
    this.onRefresh,
    this.shouldScroll = true,
    this.forceScroll = false,
    this.margin = EdgeInsets.zero,
  }) : measures = Measures(
          searchTextFieldHeight: appBar.searchBar!.height,
          largeTitleContainerHeight: appBar.largeTitle!.height,
          primaryToolbarHeight: appBar.height,
          bottomToolbarHeight: appBar.bottom!.height,
          searchBarAnimationDurationx: appBar.searchBar!.animationDuration,
        );

  final FutureOr<dynamic> Function()? onRefresh;
  final AppBarSettings appBar;
  final Widget body;
  final Brightness? brightness;
  final Measures measures;
  final ValueChanged<bool>? onCollapsed;
  late final ScrollController? scrollController;
  final bool shouldScroll;
  final bool shouldStretch;
  final bool shouldTransiteBetweenRoutes;
  final bool forceScroll;
  final EdgeInsets margin;

  @override
  State<CupertinoScaffold> createState() => _SuperScaffoldState();
}

class _SuperScaffoldState extends State<CupertinoScaffold> {
  final _isContentScrollable = ValueNotifier<bool>(false);
  late final NavigationBarStaticComponentsKeys _keys;
  final _nestedScrollViewKey = GlobalKey<NestedScrollViewStatePlus>();
  late final IndicatorStateListenable _refreshListenable;
  late final ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    _isContentScrollable.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _keys = NavigationBarStaticComponentsKeys();
    _scrollController = widget.scrollController ?? ScrollController();
    _refreshListenable = IndicatorStateListenable();

    if (widget.forceScroll) {
      _isContentScrollable.value = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_nestedScrollViewKey.currentState!.innerController.position.maxScrollExtent > 0) {
          _isContentScrollable.value = true;
        } else {
          _isContentScrollable.value = false;
        }
      });
    }
  }

  Store get _store => Store.instance();

  Widget? _getTitle() {
    if (widget.appBar.title is Text) {
      return Text(
        '${(widget.appBar.title! as Text).data}',
        style: titleTextStyle(context, widget.appBar),
      );
    } else {
      return widget.appBar.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final components = NavigationBarStaticComponents(
      keys: _keys,
      route: ModalRoute.of(context),
      userLeading: widget.appBar.leading,
      automaticallyImplyLeading: widget.appBar.automaticallyImplyLeading,
      automaticallyImplyTitle: true,
      previousPageTitle: widget.appBar.previousPageTitle,
      userMiddle: _getTitle(),
      userTrailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [...widget.appBar.actions],
      ),
      largeTitleActions: Row(children: [...?widget.appBar.largeTitle!.actions]),
      userLargeTitle: Text(
        widget.appBar.largeTitle!.largeTitle,
        style: widget.appBar.largeTitle!.textStyle ?? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
      ),
      appbarBottom: widget.appBar.bottom!.child,
      padding: null,
      large: true,
    );

    return PopScope(
      canPop: !_store.searchBarHasFocus.value,
      child: CupertinoPageScaffold(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Body(
              scrollController: _scrollController,
              topPadding: topPadding,
              measures: widget.measures,
              scrollBehavior: widget.appBar.searchBar!.scrollBehavior,
              animationBehavior: widget.appBar.searchBar!.animationBehavior,
              body: widget.body,
              onRefresh: widget.onRefresh,
              refreshListenable: _refreshListenable,
              isScrollEnabled: _isContentScrollable,
              nestedScrollViewKey: _nestedScrollViewKey,
              margin: widget.margin,
            ),
            SearchBarResult(
              topPadding: topPadding,
              measures: widget.measures,
              searchBar: widget.appBar.searchBar!,
            ),
            AnimatedAppBarBuilder(
              refreshListenable: _refreshListenable,
              scrollController: _scrollController,
              measures: widget.measures,
              appBar: widget.appBar,
              components: components,
              keys: _keys,
              topPadding: topPadding,
              shouldStretch: widget.shouldStretch,
              shouldTransiteBetweenRoutes: widget.shouldTransiteBetweenRoutes,
              onCollapsed: widget.onCollapsed,
              brightness: widget.brightness,
              isScrollEnabled: _isContentScrollable,
            ),
            Refresher(
              topPadding: topPadding,
              refreshListenable: _refreshListenable,
            ),
          ],
        ),
      ),
    );
  }
}
