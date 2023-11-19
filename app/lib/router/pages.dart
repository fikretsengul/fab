import 'package:deps/core/routing/routing.dart';
import 'package:deps/features/auth.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../pages/app_layout.page.dart';
import '../pages/fonts.page.dart';
import '../pages/home.page.dart';
import '../pages/settings.page.dart';

final homeTabKey = GlobalKey<NavigatorState>();
final settingsTabKey = GlobalKey<NavigatorState>();

enum Pages {
  login(name: 'Login', path: '/login'),

  home(name: 'Home', path: '/'),
  fonts(name: 'Fonts', path: 'fonts'),

  settings(name: 'Settings', path: '/settings');

  const Pages({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}

final List<PageDelegate> pages = [
  StatefulLayoutPage(
    builder: (_, __, shell) => AppLayoutPage(
      shell,
      destinations: [
        NavigationDestination(
          icon: Icon(UIcons.boldRounded.home),
          label: Pages.home.name,
        ),
        NavigationDestination(
          icon: Icon(UIcons.boldRounded.settings),
          label: Pages.settings.name,
        ),
      ],
    ),
    branches: {
      homeTabKey: [
        CustomPage(
          name: Pages.home.name,
          path: Pages.home.path,
          builder: (_, __) => const HomePage(),
          pages: [
            CustomPage(
              name: Pages.fonts.name,
              path: Pages.fonts.path,
              builder: (_, state) => FontsPage(
                title: state.name,
              ),
            ),
          ],
        ),
      ],
      settingsTabKey: [
        CustomPage(
          name: Pages.settings.name,
          path: Pages.settings.path,
          builder: (_, __) => const SettingsPage(),
        ),
      ],
    },
  ),
  CustomPage(
    name: Pages.login.name,
    path: Pages.login.path,
    builder: (_, __) => const LoginScreen(),
  ),
];
