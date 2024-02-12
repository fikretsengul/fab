// ignore_for_file: max_lines_for_function, max_lines_for_file
import 'package:deps/design/design.dart';
import 'package:deps/packages/adaptive_theme.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/settings_list.dart';
import 'widgets/settings_section.dart';
import 'widgets/settings_tile.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return FabScaffold(
      appBar: FabAppBarSettings(
        title: const Text(
          'Settings',
        ),
        largeTitle: FabAppBarLargeTitleSettings(
          largeTitle: 'Settings',
        ),
      ),
      child: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('APPEARANCE'),
            tiles: [
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    darkTheme = value;
                  });

                  if (value) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                },
                initialValue: darkTheme,
                title: const Text('Dark Appearance'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('DISPLAY ZOOM'),
            tiles: [
              SettingsTile.navigation(
                onPressed: (_) {},
                title: const Text('View'),
                value: const Text('Standard'),
                description: const Text(
                  'Choose a view for iPhone. '
                  'Zoomed shadows larger controls. '
                  'Standart shows more content.',
                ),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('UI AUTOMATION'),
            tiles: [
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                title: const Text('Enable UI Automation'),
              ),
              SettingsTile.navigation(
                title: const Text('Multipath Networking'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: false,
                title: const Text('HTTP/3'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('STATE RESTORATION TESTING'),
            tiles: [
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: false,
                title: const Text(
                  'Fast App Termination',
                ),
                description: const Text(
                  'Terminate instead of suspending apps when backgrounded to '
                  'force apps to be relaunched when tray '
                  'are foregrounded.',
                ),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('IAD DEVELOPER APP TESTING'),
            tiles: [
              SettingsTile.navigation(
                title: const Text('Fill Rate'),
              ),
              SettingsTile.navigation(
                title: const Text('Add Refresh Rate'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: false,
                title: const Text('Unlimited Ad Presentation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
