import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'custom_scroll_controller.dart';

/// Allows to scroll by and any [PointerDeviceKind].
/// For instance [PointerDeviceKind.touch] will work on desktop web (DartPad).
class ScrollByAnyDeviceScrollBehaviour extends MaterialScrollBehavior {
  const ScrollByAnyDeviceScrollBehaviour();

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Set<PointerDeviceKind> get dragDevices => const {...PointerDeviceKind.values};
}

class CustomScrollProvider extends StatefulWidget {
  const CustomScrollProvider({
    required this.tabController,
    required this.parent,
    required this.child,
    super.key,
  });

  final TabController tabController;
  final ScrollController parent;
  final Widget child;

  @override
  State<CustomScrollProvider> createState() => CustomScrollProviderState();
}

class CustomScrollProviderState extends State<CustomScrollProvider> {
  late final List<CustomScrollController> scrollControllers;

  @override
  void initState() {
    super.initState();

    final activeIndex = widget.tabController.index;

    scrollControllers = List.generate(
      widget.tabController.length,
      (index) => CustomScrollController(
        isActive: index == activeIndex,
        parent: widget.parent,
        debugLabel: 'CustomScrollController/$index',
      ),
    );

    widget.tabController.addListener(() {
      changeActiveIndex(widget.tabController.index);
    });
  }

  @override
  void dispose() {
    for (final scrollController in scrollControllers) {
      scrollController.dispose();
    }

    super.dispose();
  }

  void changeActiveIndex(int value) {
    for (var i = 0; i < scrollControllers.length; i++) {
      final scrollController = scrollControllers[i];
      final isActive = i == value;
      scrollController.isActive = isActive;

      if (isActive) {
        scrollController.forceAttach();
      } else {
        scrollController.forceDetach();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollProviderData(
      scrollControllers: scrollControllers,
      child: widget.child,
    );
  }
}

class CustomScrollProviderData extends InheritedWidget {
  const CustomScrollProviderData({
    required super.child,
    required this.scrollControllers,
    super.key,
  });

  static CustomScrollProviderData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomScrollProviderData>()!;
  }

  final List<CustomScrollController> scrollControllers;

  @override
  bool updateShouldNotify(CustomScrollProviderData oldWidget) {
    return scrollControllers != oldWidget.scrollControllers;
  }
}
