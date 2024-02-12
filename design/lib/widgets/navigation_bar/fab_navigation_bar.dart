import 'package:deps/packages/fpdart.dart';
import 'package:flutter/cupertino.dart';

import '../../design.dart';

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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.fabTheme.borderColor.withOpacity(1),
            width: 0,
          ),
        ),
      ),
      child: CupertinoTabBar(
        backgroundColor: context.fabTheme.backgroundColor,
        activeColor: context.fabTheme.primaryColor,
        inactiveColor: context.fabTheme.inactiveColor,
        currentIndex: currentIndex,
        onTap: onTap,
        iconSize: 20,
        items: items
            .mapWithIndex(
              (item, index) => BottomNavigationBarItem(
                icon: index == currentIndex ? item.selectedIcon : item.icon,
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class CupertinoNavigationBarItem {
  CupertinoNavigationBarItem({required this.icon, required this.selectedIcon, required this.label});
  final Widget icon;
  final Widget selectedIcon;
  final String label;
}
