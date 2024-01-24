import 'package:flutter/cupertino.dart';

import 'settings_section.dart';
import 'settings_theme.dart';
import 'settings_theme_data.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.sections,
    super.key,
  });

  final List<SettingsSection> sections;

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? MediaQuery.platformBrightnessOf(context);
    final themeData = iosTheme(brightness);

    return SettingsTheme(
      themeData: themeData,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          return sections[index];
        },
      ),
    );
  }
}
