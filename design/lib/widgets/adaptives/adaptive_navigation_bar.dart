import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NavigationBarStyle { material, cupertino, adaptive }

class AdaptiveNavigationBar extends StatelessWidget {
  const AdaptiveNavigationBar._({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.style,
    super.key,
  });

  factory AdaptiveNavigationBar.material({
    required int currentIndex,
    required Function(int index) onTap,
    required List<AdaptiveNavItem> items,
    Key? key,
  }) =>
      AdaptiveNavigationBar._(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        style: NavigationBarStyle.material,
        key: key,
      );

  factory AdaptiveNavigationBar.cupertino({
    required int currentIndex,
    required Function(int index) onTap,
    required List<AdaptiveNavItem> items,
    Key? key,
  }) =>
      AdaptiveNavigationBar._(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        style: NavigationBarStyle.cupertino,
        key: key,
      );

  factory AdaptiveNavigationBar.adaptive({
    required int currentIndex,
    required Function(int index) onTap,
    required List<AdaptiveNavItem> items,
    Key? key,
  }) =>
      AdaptiveNavigationBar._(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        style: NavigationBarStyle.adaptive,
        key: key,
      );

  final int currentIndex;
  final Function(int index) onTap;
  final List<AdaptiveNavItem> items;
  final NavigationBarStyle style;

  @override
  Widget build(BuildContext context) {
    final actualStyle = style == NavigationBarStyle.adaptive
        ? ($.platform.isIOS ? NavigationBarStyle.cupertino : NavigationBarStyle.material)
        : style;

    if (actualStyle == NavigationBarStyle.material) {
      return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        destinations: items.map((item) => NavigationDestination(icon: item.icon, label: item.label)).toList(),
      );
    } else {
      return CupertinoTabBar(
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        onTap: onTap,
        iconSize: 20,
        items: items.map((item) => BottomNavigationBarItem(icon: item.icon, label: item.label)).toList(),
      );
    }
  }
}

class AdaptiveNavItem {
  AdaptiveNavItem({required this.icon, required this.label});
  final Widget icon;
  final String label;
}
