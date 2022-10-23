import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/api_feature_screen.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/color_picker.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/info_card.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/theme_card.dart';
import 'package:flutter_advanced_boilerplate/theme/app_theme_creator.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    const feateures = [
      InfoCard(
        title: 'screens.features.api.title',
        content: 'screens.features.api.explanation',
        icon: Ionicons.swap_vertical_outline,
        widget: ApiFeatureScreen(),
      ),
      InfoCard(
        title: 'screens.features.state.title',
        content: 'screens.features.state.explanation',
        icon: Ionicons.leaf_outline,
      ),
      InfoCard(
        title: 'screens.features.linting.title',
        content: 'screens.features.linting.explanation',
        icon: Ionicons.code_slash_outline,
      ),
      InfoCard(
        title: 'screens.features.di_locator.title',
        content: 'screens.features.di_locator.explanation',
        icon: Ionicons.locate_outline,
      ),
      InfoCard(
        title: 'screens.features.code_generation.title',
        content: 'screens.features.code_generation.explanation',
        icon: Ionicons.speedometer_outline,
      ),
      InfoCard(
        title: 'screens.features.routing.title',
        content: 'screens.features.routing.explanation',
        icon: Ionicons.chevron_back_outline,
      ),
      InfoCard(
        title: 'screens.features.pattern.title',
        content: 'screens.features.pattern.explanation',
        icon: Ionicons.apps_outline,
      ),
      InfoCard(
        title: 'screens.features.exceptions.title',
        content: 'screens.features.exceptions.explanation',
        icon: Ionicons.alert_circle_outline,
      ),
      InfoCard(
        title: 'screens.features.storage.title',
        content: 'screens.features.storage.explanation',
        icon: Ionicons.folder_open_outline,
      ),
      InfoCard(
        title: 'screens.features.dynamic_theme.title',
        content: 'screens.features.dynamic_theme.explanation',
        icon: Ionicons.color_palette_outline,
      ),
      InfoCard(
        title: 'screens.features.localization.title',
        content: 'screens.features.localization.explanation',
        icon: Ionicons.earth_outline,
      ),
      InfoCard(
        title: 'screens.features.logging.title',
        content: 'screens.features.logging.explanation',
        icon: Ionicons.terminal_outline,
      ),
      InfoCard(
        title: 'screens.features.native_splash.title',
        content: 'screens.features.native_splash.explanation',
        icon: Ionicons.star_outline,
      ),
      InfoCard(
        title: 'screens.features.env_variables.title',
        content: 'screens.features.env_variables.explanation',
        icon: Ionicons.medical_outline,
      ),
      InfoCard(
        title: 'screens.features.refresh_rate.title',
        content: 'screens.features.refresh_rate.explanation',
        icon: Ionicons.pulse_outline,
      ),
    ];

    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            elevation: 0,
            color: getPrimaryColor(context),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: SwitchListTile(
              onChanged: (bool newValue) {
                /// Example: Change locale
                /// The initial locale is automatically determined by the library.
                /// Changing the locale like this will persist the selected locale.
                context.setLocale(
                  newValue ? const Locale('tr') : const Locale('en'),
                );
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              value: context.locale == const Locale('tr'),
              title: Row(
                children: [
                  Icon(
                    Ionicons.language_outline,
                    color: getTheme(context).primary,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    tr('screens.features.use_turkish'),
                    style: getTextTheme(context).titleSmall!.apply(fontWeightDelta: 2),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 1,
            padding: EdgeInsets.zero,
            children: [
              ThemeCard(
                mode: AdaptiveThemeMode.light,
                icon: Ionicons.sunny_outline,
                onTap: () => AdaptiveTheme.of(context).setLight(),
              ),
              ThemeCard(
                mode: AdaptiveThemeMode.dark,
                icon: Ionicons.moon_outline,
                onTap: () => AdaptiveTheme.of(context).setDark(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FastColorPicker(
            selectedColor: getTheme(context).primary,
            icon: Ionicons.color_palette_outline,
            iconColor: getTheme(context).background,
            onColorSelected: (color) async {
              final lightThemeData = await createAppTheme(color: color);
              final darkThemeData = await createAppTheme(isDark: true, color: color);

              if (!mounted) return;
              AdaptiveTheme.of(context).setTheme(
                light: lightThemeData.materialThemeData,
                dark: darkThemeData.materialThemeData,
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          MasonryGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: feateures.length,
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              return feateures.elementAt(index);
            },
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
