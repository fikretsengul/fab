import 'package:deps/packages/fpdart.dart';
import 'package:flutter/cupertino.dart';

class FabNavigationBar extends StatelessWidget {
  const FabNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final Function(int index) onTap;
  final List<CupertinoNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      currentIndex: currentIndex,
      onTap: onTap,
      iconSize: 19,
      items: items
          .mapWithIndex(
            (item, index) => BottomNavigationBarItem(
              icon: index == currentIndex ? item.selectedIcon : item.icon,
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

class CupertinoNavigationBarItem {
  CupertinoNavigationBarItem({required this.icon, required this.selectedIcon, required this.label});
  final Widget icon;
  final Widget selectedIcon;
  final String label;
}
