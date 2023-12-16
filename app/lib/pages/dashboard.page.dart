import 'package:deps/infrastructure/commons.dart';
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
      appBarBuilder: (_, tabsRouter) => AppBar(
        leading: const AutoLeadingButton(),
        title: Text(
          localizedRouteTitlesMap()[tabsRouter.topRoute.name] ?? '',
          style: context.textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
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
