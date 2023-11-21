/* // ignore_for_file: avoid_returning_widgets
import 'package:deps/design/design.dart';
import 'package:deps/packages/go_router.dart';
import 'package:flutter/material.dart';

class AppLayoutPage extends StatelessWidget {
  AppLayoutPage(
    this.shell, {
    required this.destinations,
    super.key,
  });

  final StatefulNavigationShell shell;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: FabBottomNavBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: destinations,
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    shell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == shell.currentIndex,
    );
  }
}
 */
