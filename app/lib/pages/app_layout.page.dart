// ignore_for_file: avoid_returning_widgets
import 'package:deps/design/design.dart';
import 'package:deps/packages/go_router.dart';
import 'package:flutter/material.dart';

import '../router/pages.dart';

typedef OnNavCallback = ValueChanged<BuildContext>;

class Destination {
  const Destination({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final Widget icon;
  final String label;
  final Widget? selectedIcon;
}

class AppLayoutPage extends StatelessWidget {
  AppLayoutPage(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  final _destination = [
    Destination(
      label: Pages.home.name,
      icon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home),
    ),
    Destination(
      label: Pages.settings.name,
      icon: const Icon(Icons.search_outlined),
      selectedIcon: const Icon(Icons.search),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      appBar: FabAppBar(),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: _destination.map((e) => e.toNavDestination()).toList(),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

extension on Destination {
  NavigationDestination toNavDestination() {
    return NavigationDestination(
      icon: icon,
      label: label,
      selectedIcon: selectedIcon,
    );
  }
}
