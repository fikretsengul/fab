import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../router/router.gr.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRouter(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(UIcons.boldRounded.home, size: 16),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(UIcons.boldRounded.settings, size: 16),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
