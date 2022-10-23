import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/features/features_screen.dart';
import 'package:flutter_advanced_boilerplate/features/informations/informations_screen.dart';
import 'package:ionicons/ionicons.dart';

@immutable
abstract class Navigation {
  const Navigation._();

  /// Appbar configuration.
  static final appbars = <AppBar>[
    AppBar(
      title: Text(
        tr('core.navigation.bottom.features'),
      ),
    ),
    AppBar(
      title: Text(
        tr('core.navigation.bottom.informations'),
      ),
    ),
  ];

  /// Bottom navigation configuration.
  static const bottomNavigationScreens = <Widget>[
    FeaturesScreen(),
    InformationsScreen(),
  ];

  static final bottomNavigationItems = [
    NavigationDestination(
      icon: const Icon(
        Ionicons.eye_outline,
        size: 24,
      ),
      label: tr('core.navigation.bottom.features'),
    ),
    NavigationDestination(
      icon: const Icon(
        Ionicons.information_circle_outline,
        size: 24,
      ),
      label: tr('core.navigation.bottom.informations'),
    ),
  ];
}
