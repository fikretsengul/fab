import 'package:deps/core/routing/page.dart';
import 'package:deps/features/auth.dart';
import 'package:flutter/material.dart';

import '../pages/app_layout.page.dart';
import '../pages/home.page.dart';
import '../pages/settings.page.dart';

GlobalKey<NavigatorState> homeTabKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> settingsTabKey = GlobalKey<NavigatorState>();

enum Pages {
  login('login', '/login'),
  home('home', '/'),
  settings('settings', '/settings');

  const Pages(this.name, this.path);

  final String name;
  final String path;
}

final List<PageDelegate> pages = [
  StatefulLayoutPage(
    builder: (_, __, navigationShell) => AppLayoutPage(navigationShell),
    branches: {
      homeTabKey: [
        SinglePage(
          name: Pages.home.name,
          path: Pages.home.path,
          builder: (_) => const HomePage(),
        ),
      ],
      settingsTabKey: [
        SinglePage(
          name: Pages.settings.name,
          path: Pages.settings.path,
          builder: (_) => const SettingsPage(),
        ),
      ],
    },
  ),
  SinglePage(
    name: Pages.login.name,
    path: Pages.login.path,
    builder: (_) => const LoginScreen(),
  ),
];
