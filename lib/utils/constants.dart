import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/features/features_screen.dart';
import 'package:flutter_advanced_boilerplate/features/informations/informations_screen.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final $constants = Constants();

@immutable
class Constants {
  /// API configuration.
  late final api = _API();

  final appTitle = 'Flutter Advanced Boilerplate';

  /// Rounded edge corner radiuses.
  late final corners = _Corners();

  /// Padding and margin values.
  late final insets = _Insets();

  /// Navigation configuration.
  late final navigation = _Navigation();

  /// Color $constants.palette.
  late final palette = _Palette();

  /// Text shadows.
  late final shadows = _Shadows();

  /// Theme defaults.
  late final theme = _Theme();

  /// Animation durations.
  late final times = _Times();
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration pageTransition = const Duration(milliseconds: 200);
  final Duration slow = const Duration(milliseconds: 900);
}

@immutable
class _Corners {
  late final double lg = 32;
  late final double md = 8;
  late final double sm = 4;
}

@immutable
class _Insets {
  late final double lg = 32;
  late final double md = 24;
  late final double offset = 80;
  late final double sm = 16;
  late final double xl = 48;
  late final double xs = 8;
  late final double xxl = 56;
  late final double xxs = 4;
}

@immutable
class _Shadows {
  final text = [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: const Offset(0, 2),
      blurRadius: 2,
    ),
  ];

  final textSoft = [
    Shadow(
      color: Colors.black.withOpacity(0.25),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  final textStrong = [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: const Offset(0, 4),
      blurRadius: 6,
    ),
  ];
}

@immutable
class _Palette {
  final black = const Color(0xFF000000);
  final blue = const Color(0xFF0000FF);
  final cyan = const Color(0xFF00FFFF);
  final green = const Color(0xFF66B032);
  final grey = const Color(0xFF9E9E9E);
  final magenta = const Color(0xFFFF00FF);
  final orange = const Color(0xFFFF8000);
  final purple = const Color(0xFF0080FF);
  final red = const Color(0xFFFF0000);
  final List<Color> themes = [
    const Color(0xFFFF0000),
    const Color(0xFFFF8000),
    const Color(0xFFFCCC1A),
    const Color(0xFF66B032),
    const Color(0xFF00FFFF),
    const Color(0xFF0000FF),
    const Color(0xFF0080FF),
    const Color(0xFFFF00FF),
  ];

  final white = const Color(0xFFFFFFFF);
  final yellow = const Color(0xFFFCCC1A);
}

@immutable
class _Theme {
  final double defaultBorderRadius = 24;
  final double defaultElevation = 0;
  final defaultFontFamily = 'Nunito';
  final defaultThemeColor = const Color(0xFF0000FF);
  final tryToGetColorPaletteFromWallpaper = true;
}

@immutable
class _API {
  final maxItemToBeFetchedAtOneTime = 5;
}

@immutable
class _Navigation {
  /// Appbar configuration.
  List<AppBar> appbars(BuildContext context) => [
        AppBar(
          leading: IconButton(
            onPressed: () => getIt<AuthCubit>().logOut(),
            icon: Icon(MdiIcons.logout),
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
  List<Widget> bottomNavigationScreens() => const [
        FeaturesScreen(),
        InformationsScreen(),
      ];

  List<NavigationDestination> bottomNavigationItems(BuildContext context) => [
        NavigationDestination(
          icon: Icon(
            MdiIcons.fire,
            size: 24,
          ),
          label: context.t.core.navigation.bottom.features,
        ),
        NavigationDestination(
          icon: Icon(
            MdiIcons.information,
            size: 24,
          ),
          label: context.t.core.navigation.bottom.informations,
        ),
      ];
}
