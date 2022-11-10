import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/api_feature_screen.dart';
import 'package:flutter_advanced_boilerplate/features/features/widgets/components/info_card.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keframe/keframe.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});

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
        title: context.t.features.performance.title,
        content: context.t.features.performance.explanation,
        icon: MdiIcons.speedometer,
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
        title: context.t.features.permission.title,
        content: context.t.features.permission.explanation,
        icon: MdiIcons.lockAlert,
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

    return SizeCacheWidget(
      estimateCount: features.length * 2,
      child: MasonryGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemBuilder: (context, index) {
          return FrameSeparateWidget(
            index: index,
            placeHolder: const InfoCard(
              title: '',
              content: '',
              isPlaceholder: true,
            ),
            child: features.elementAt(index),
          );
        },
      ),
    );
  }
}
