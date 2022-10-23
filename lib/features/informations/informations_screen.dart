import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/informations/widgets/grid_item.dart';
import 'package:flutter_advanced_boilerplate/features/informations/widgets/link_card.dart';
import 'package:flutter_advanced_boilerplate/features/informations/widgets/text_divider.dart';
import 'package:ionicons/ionicons.dart';

class InformationsScreen extends StatelessWidget {
  const InformationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          LinkCard(
            title: 'screens.informations.github_repository_title',
            icon: Ionicons.logo_github,
            url: Uri.parse(
              'https://github.com/',
            ),
          ),
          const TextDivider(text: 'screens.informations.author_divider_title'),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2 / 1.15,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              GridItem(
                title: 'screens.informations.donate_card_title',
                icon: Ionicons.heart_outline,
                url: Uri.parse(
                  'https://www.paypal.com/',
                ),
              ),
              GridItem(
                title: 'screens.informations.website_card_title',
                icon: Ionicons.desktop_outline,
                url: Uri.parse('https://fikretsengul.com'),
              ),
            ],
          ),
          const TextDivider(text: 'screens.informations.packages_divider_title'),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2 / 1.15,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              GridItem(
                title: 'dio',
                icon: Ionicons.swap_vertical_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/dio/versions/4.0.6',
                ),
                category: 'API',
              ),
              GridItem(
                title: 'graphql_flutter',
                icon: Ionicons.swap_vertical_outline,
                url: Uri.parse('https://pub.dev/packages/graphql_flutter/versions/5.1.0'),
                category: 'API',
              ),
              GridItem(
                title: 'web_socket_channel',
                icon: Ionicons.swap_vertical_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/web_socket_channel/versions/2.2.0',
                ),
                category: 'API',
              ),
              GridItem(
                title: 'internet_connection_checker',
                icon: Ionicons.swap_vertical_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/internet_connection_checker/versions/1.0.0+1',
                ),
                category: 'API',
              ),
              GridItem(
                title: 'fresh_dio',
                icon: Ionicons.key_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/fresh_dio/versions/0.3.2',
                ),
                category: 'Auth',
              ),
              GridItem(
                title: 'fresh_graphql',
                icon: Ionicons.key_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/fresh_graphql/versions/0.5.2',
                ),
                category: 'Auth',
              ),
              GridItem(
                title: 'flutter_bloc',
                icon: Ionicons.leaf_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/flutter_bloc/versions/8.1.1',
                ),
                category: 'State & Architecture',
              ),
              GridItem(
                title: 'hydrated_bloc',
                icon: Ionicons.leaf_outline,
                url: Uri.parse('https://pub.dev/packages/hydrated_bloc/versions/8.1.0'),
                category: 'State Persistance',
              ),
              GridItem(
                title: 'very_good_analysis',
                icon: Ionicons.code_slash_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/very_good_analysis/versions/3.1.0',
                ),
                category: 'Linting',
              ),
              GridItem(
                title: 'dart_code_metrics',
                icon: Ionicons.code_slash_outline,
                url: Uri.parse('https://pub.dev/packages/dart_code_metrics/versions/4.21.2'),
                category: 'Linting',
              ),
              GridItem(
                title: 'injectable',
                icon: Ionicons.locate_outline,
                url: Uri.parse('https://pub.dev/packages/injectable/versions/1.5.3'),
                category: 'DI',
              ),
              GridItem(
                title: 'get_it',
                icon: Ionicons.locate_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/get_it/versions/7.2.0',
                ),
                category: 'Locator',
              ),
              GridItem(
                title: 'freezed',
                icon: Ionicons.speedometer_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/freezed/versions/2.2.0',
                ),
                category: 'Code Generation',
              ),
              GridItem(
                title: 'artemis',
                icon: Ionicons.speedometer_outline,
                url: Uri.parse('https://pub.dev/packages/artemis/versions/6.18.4'),
                category: 'Code Generation',
              ),
              GridItem(
                title: 'build_runner',
                icon: Ionicons.speedometer_outline,
                url: Uri.parse('https://pub.dev/packages/build_runner/versions/2.3.2'),
                category: 'Code Generation',
              ),
              GridItem(
                title: 'json_serializable',
                icon: Ionicons.speedometer_outline,
                url: Uri.parse('https://pub.dev/packages/json_serializable/versions/6.5.3'),
                category: 'Code Generation',
              ),
              GridItem(
                title: 'auto_route',
                icon: Ionicons.chevron_back_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/auto_route/versions/5.0.2',
                ),
                category: 'Routing',
              ),
              GridItem(
                title: 'data_channel',
                icon: Ionicons.alert_circle_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/data_channel/versions/2.0.0+1',
                ),
                category: 'Exceptions',
              ),
              GridItem(
                title: 'hive_flutter',
                icon: Ionicons.folder_open_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/hive_flutter/versions/1.1.0',
                ),
                category: 'Storage',
              ),
              GridItem(
                title: 'flutter_secure_storage',
                icon: Ionicons.folder_open_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/flutter_secure_storage/versions/6.0.0',
                ),
                category: 'Storage',
              ),
              GridItem(
                title: 'adaptive_theme',
                icon: Ionicons.color_palette_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/adaptive_theme/versions/3.1.1',
                ),
                category: 'Theme',
              ),
              GridItem(
                title: 'easy_localization',
                icon: Ionicons.earth_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/easy_localization/versions/3.0.1',
                ),
                category: 'Localization',
              ),
              GridItem(
                title: 'logger',
                icon: Ionicons.terminal_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/logger/versions/1.1.0',
                ),
                category: 'Logging',
              ),
              GridItem(
                title: 'pretty_dio_logger',
                icon: Ionicons.terminal_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/pretty_dio_logger/versions/1.2.0-beta-1',
                ),
                category: 'Logging',
              ),
              GridItem(
                title: 'sentry_flutter',
                icon: Ionicons.bug_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/sentry_flutter/versions/6.13.1',
                ),
                category: 'Tracking',
              ),
              GridItem(
                title: 'sentry_dart_plugin',
                icon: Ionicons.bug_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/sentry_dart_plugin/versions/1.0.0-beta.4',
                ),
                category: 'Tracking',
              ),
              GridItem(
                title: 'sentry_dio',
                icon: Ionicons.bug_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/sentry_dio/versions/6.13.1',
                ),
                category: 'Tracking',
              ),
              GridItem(
                title: 'statsfl',
                icon: Ionicons.bug_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/statsfl/versions/2.3.0',
                ),
                category: 'Tracking',
              ),
              GridItem(
                title: 'flutter_displaymode',
                icon: Ionicons.pulse_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/flutter_displaymode/versions/0.4.0',
                ),
                category: 'Refresh Rate',
              ),
              GridItem(
                title: 'animations',
                icon: Ionicons.star_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/animations/versions/2.0.7',
                ),
                category: 'Animations',
              ),
              GridItem(
                title: 'ionicons',
                icon: Ionicons.diamond_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/ionicons/versions/0.2.1',
                ),
                category: 'Icons',
              ),
              GridItem(
                title: 'flutter_staggered_grid_view',
                icon: Ionicons.construct_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/flutter_staggered_grid_view/versions/0.6.2',
                ),
                category: 'Others',
              ),
              GridItem(
                title: 'custom_sliding_segmented_control',
                icon: Ionicons.construct_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/custom_sliding_segmented_control/versions/1.7.3',
                ),
                category: 'Others',
              ),
              GridItem(
                title: 'url_launcher',
                icon: Ionicons.construct_outline,
                url: Uri.parse(
                  'https://pub.dev/packages/url_launcher/versions/6.1.6',
                ),
                category: 'Others',
              ),
            ],
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
