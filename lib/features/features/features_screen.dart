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
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        icon: MdiIcons.api,
        widget: const ApiFeatureScreen(),
      ),
      InfoCard(
        title: context.t.features.state.title,
        content: context.t.features.state.explanation,
        icon: MdiIcons.stateMachine,
      ),
      InfoCard(
        title: context.t.features.linting.title,
        content: context.t.features.linting.explanation,
        icon: MdiIcons.spellcheck,
      ),
      InfoCard(
        title: context.t.features.type_safety.title,
        content: context.t.features.type_safety.explanation,
        icon: MdiIcons.lightbulbAlert,
      ),
      InfoCard(
        title: context.t.features.forms.title,
        content: context.t.features.forms.explanation,
        icon: MdiIcons.lightbulbAlert,
      ),
      InfoCard(
        title: context.t.features.testing.title,
        content: context.t.features.testing.explanation,
        icon: MdiIcons.lightbulbAlert,
      ),
      InfoCard(
        title: context.t.features.di_locator.title,
        content: context.t.features.di_locator.explanation,
        icon: MdiIcons.crosshairsGps,
      ),
      InfoCard(
        title: context.t.features.code_generation.title,
        content: context.t.features.code_generation.explanation,
        icon: MdiIcons.fileCode,
      ),
      InfoCard(
        title: context.t.features.ci_cd.title,
        content: context.t.features.ci_cd.explanation,
        icon: MdiIcons.cloudTags,
      ),
      InfoCard(
        title: context.t.features.routing.title,
        content: context.t.features.routing.explanation,
        icon: MdiIcons.routes,
      ),
      InfoCard(
        title: context.t.features.pattern.title,
        content: context.t.features.pattern.explanation,
        icon: MdiIcons.folderNetwork,
      ),
      InfoCard(
        title: context.t.features.exceptions.title,
        content: context.t.features.exceptions.explanation,
        icon: MdiIcons.alert,
      ),
      InfoCard(
        title: context.t.features.storage.title,
        content: context.t.features.storage.explanation,
        icon: MdiIcons.database,
      ),
      InfoCard(
        title: context.t.features.dynamic_theme.title,
        content: context.t.features.dynamic_theme.explanation,
        icon: MdiIcons.shape,
      ),
      InfoCard(
        title: context.t.features.localization.title,
        content: context.t.features.localization.explanation,
        icon: MdiIcons.translate,
      ),
      InfoCard(
        title: context.t.features.env_variables.title,
        content: context.t.features.env_variables.explanation,
        icon: MdiIcons.arrowDecision,
      ),
      InfoCard(
        title: context.t.features.logging.title,
        content: context.t.features.logging.explanation,
        icon: MdiIcons.mathLog,
      ),
      InfoCard(
        title: context.t.features.native_splash.title,
        content: context.t.features.native_splash.explanation,
        icon: MdiIcons.cellphoneScreenshot,
      ),
      InfoCard(
        title: context.t.features.refresh_rate.title,
        content: context.t.features.refresh_rate.explanation,
        icon: MdiIcons.speedometer,
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
                LocaleSettings.setLocale(newValue ? AppLocale.tr : AppLocale.en);
              },
              value: context.t.$meta.locale == AppLocale.tr,
              title: Row(
                children: [
                  const Icon(MdiIcons.translate),
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
                icon: MdiIcons.brightnessAuto,
                onTap: () => getIt<AppCubit>().setThemeMode(mode: ThemeMode.system),
              ),
              ThemeCard(
                mode: ThemeMode.light,
                icon: MdiIcons.brightness7,
                onTap: () => getIt<AppCubit>().setThemeMode(mode: ThemeMode.light),
              ),
              ThemeCard(
                mode: ThemeMode.dark,
                icon: MdiIcons.brightness1,
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
                icon: MdiIcons.palette,
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
