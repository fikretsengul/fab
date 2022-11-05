import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/api_feature_screen.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/color_picker.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/info_card.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/theme_card.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final features = [
      InfoCard(
        title: context.t.features.api.title,
        content: context.t.features.api.explanation,
        icon: Ionicons.swap_vertical_outline,
        widget: const ApiFeatureScreen(),
      ),
      InfoCard(
        title: context.t.features.state.title,
        content: context.t.features.state.explanation,
        icon: Ionicons.leaf_outline,
      ),
      InfoCard(
        title: context.t.features.linting.title,
        content: context.t.features.linting.explanation,
        icon: Ionicons.code_slash_outline,
      ),
      InfoCard(
        title: context.t.features.di_locator.title,
        content: context.t.features.di_locator.explanation,
        icon: Ionicons.locate_outline,
      ),
      InfoCard(
        title: context.t.features.code_generation.title,
        content: context.t.features.code_generation.explanation,
        icon: Ionicons.speedometer_outline,
      ),
      InfoCard(
        title: context.t.features.routing.title,
        content: context.t.features.routing.explanation,
        icon: Ionicons.chevron_back_outline,
      ),
      InfoCard(
        title: context.t.features.pattern.title,
        content: context.t.features.pattern.explanation,
        icon: Ionicons.apps_outline,
      ),
      InfoCard(
        title: context.t.features.exceptions.title,
        content: context.t.features.exceptions.explanation,
        icon: Ionicons.alert_circle_outline,
      ),
      InfoCard(
        title: context.t.features.storage.title,
        content: context.t.features.storage.explanation,
        icon: Ionicons.folder_open_outline,
      ),
      InfoCard(
        title: context.t.features.dynamic_theme.title,
        content: context.t.features.dynamic_theme.explanation,
        icon: Ionicons.color_palette_outline,
      ),
      InfoCard(
        title: context.t.features.localization.title,
        content: context.t.features.localization.explanation,
        icon: Ionicons.earth_outline,
      ),
      InfoCard(
        title: context.t.features.logging.title,
        content: context.t.features.logging.explanation,
        icon: Ionicons.terminal_outline,
      ),
      InfoCard(
        title: context.t.features.native_splash.title,
        content: context.t.features.native_splash.explanation,
        icon: Ionicons.star_outline,
      ),
      InfoCard(
        title: context.t.features.env_variables.title,
        content: context.t.features.env_variables.explanation,
        icon: Ionicons.medical_outline,
      ),
      InfoCard(
        title: context.t.features.refresh_rate.title,
        content: context.t.features.refresh_rate.explanation,
        icon: Ionicons.pulse_outline,
      ),
    ];

    return Material(
      color: getTheme(context).background,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            child: SwitchListTile(
              onChanged: (bool newValue) {
                /// Example: Change locale
                /// The initial locale is automatically determined by the library.
                /// Changing the locale like this will persist the selected locale.
                // Use generated localization.
                LocaleSettings.setLocale(newValue ? AppLocale.tr : AppLocale.en);
              },
              value: context.t.$meta.locale == AppLocale.tr,
              title: Row(
                children: [
                  const Icon(
                    Ionicons.language_outline,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    context.t.features.use_turkish,
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
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2 / 1,
            padding: EdgeInsets.zero,
            children: [
              ThemeCard(
                mode: ThemeMode.system,
                icon: Ionicons.contrast_outline,
                onTap: () => getIt<AppCubit>().setThemeMode(mode: ThemeMode.system),
              ),
              ThemeCard(
                mode: ThemeMode.light,
                icon: Ionicons.sunny_outline,
                onTap: () => getIt<AppCubit>().setThemeMode(mode: ThemeMode.light),
              ),
              ThemeCard(
                mode: ThemeMode.dark,
                icon: Ionicons.moon_outline,
                onTap: () => getIt<AppCubit>().setThemeMode(mode: ThemeMode.dark),
              ),
            ],
          ),
          const SizedBox(height: 8),
          BlocBuilder<AppCubit, AppState>(
            buildWhen: (p, c) => p.theme != c.theme,
            builder: (context, state) {
              return FastColorPicker(
                selectedColor: getTheme(context).primary,
                icon: Ionicons.color_palette_outline,
                iconColor: getTheme(context).background,
                disabled: state.theme.mode == ThemeMode.system,
                onColorSelected: (color) => getIt<AppCubit>().setThemeColor(color: color),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: getTheme(context).onBackground.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          MasonryGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              return features.elementAt(index);
            },
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
