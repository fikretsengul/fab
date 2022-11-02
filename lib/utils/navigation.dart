import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/features/features_screen.dart';
import 'package:flutter_advanced_boilerplate/features/informations/informations_screen.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@immutable
abstract class Navigation {
  const Navigation._();

  /// Appbar configuration.
  static List<AppBar> appbars(BuildContext context) => [
        AppBar(
          leading: IconButton(
            onPressed: () => getIt<AuthCubit>().logOut(),
            icon: const Icon(MdiIcons.logout),
          ),
          title: Text(
            context.t.core.navigation.bottom.features,
          ),
        ),
        AppBar(
          title: Text(
            context.t.core.navigation.bottom.informations,
          ),
        ),
      ];

  /// Bottom navigation configuration.
  static List<Widget> bottomNavigationScreens(BuildContext context) => const [
        FeaturesScreen(),
        InformationsScreen(),
      ];

  static List<NavigationDestination> bottomNavigationItems(BuildContext context) => [
        NavigationDestination(
          icon: const Icon(
            Ionicons.eye_outline,
            size: 24,
          ),
          label: context.t.core.navigation.bottom.features,
        ),
        NavigationDestination(
          icon: const Icon(
            Ionicons.information_circle_outline,
            size: 24,
          ),
          label: context.t.core.navigation.bottom.informations,
        ),
      ];
}
