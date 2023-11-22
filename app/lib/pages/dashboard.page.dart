import 'package:deps/design/design.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../routes/router.dart';
import '../routes/router.gr.dart';

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
      appBarBuilder: (_, tabsRouter) => FabAppBar(
        title: localizedRouteTitlesMap()[tabsRouter.topRoute.name] ?? '',
      ),
      bottomNavigationBuilder: (_, tabsRouter) {
        return FabBottomNavBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(UIcons.boldRounded.home, size: 16),
              label: localizedRouteTitlesMap()[HomeRoute.name] ?? 'Home',
            ),
            NavigationDestination(
              icon: Icon(UIcons.boldRounded.settings, size: 16),
              label: localizedRouteTitlesMap()[SettingsRoute.name] ?? 'Settings',
            ),
          ],
        );
      },
    );
  }
}
