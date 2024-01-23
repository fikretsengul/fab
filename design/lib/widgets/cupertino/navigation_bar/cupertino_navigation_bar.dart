import 'package:flutter/cupertino.dart';

class CupertinoNavigationBar extends StatelessWidget {
  const CupertinoNavigationBar({
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
      items: items.map((item) => BottomNavigationBarItem(icon: item.icon, label: item.label)).toList(),
    );
  }
}

class CupertinoNavigationBarItem {
  CupertinoNavigationBarItem({required this.icon, required this.label});
  final Widget icon;
  final String label;
}
