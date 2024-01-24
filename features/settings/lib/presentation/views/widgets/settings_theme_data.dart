import 'package:flutter/cupertino.dart';

import 'settings_theme.dart';

SettingsThemeData iosTheme(Brightness brightness) {
  const lightSettingsListBackground = Color.fromRGBO(242, 242, 247, 1);
  const darkSettingsListBackground = CupertinoColors.black;

  const lightSettingSectionColor = CupertinoColors.white;
  const darkSettingSectionColor = Color.fromARGB(255, 28, 28, 30);

  const lightSettingsTitleColor = Color.fromRGBO(109, 109, 114, 1);
  const darkSettingsTitleColor = CupertinoColors.systemGrey;

  const lightDividerColor = Color.fromARGB(255, 238, 238, 238);
  const darkDividerColor = Color.fromARGB(255, 40, 40, 42);

  const lightTrailingTextColor = Color.fromARGB(255, 138, 138, 142);
  const darkTrailingTextColor = Color.fromARGB(255, 152, 152, 159);

  const lightTileHighlightColor = Color.fromARGB(255, 209, 209, 214);
  const darkTileHighlightColor = Color.fromARGB(255, 58, 58, 60);

  const lightSettingsTileTextColor = CupertinoColors.black;
  const darkSettingsTileTextColor = CupertinoColors.white;

  const lightLeadingIconsColor = CupertinoColors.inactiveGray;
  const darkLeadingIconsColor = CupertinoColors.inactiveGray;

  final isLight = brightness == Brightness.light;

  final listBackground = isLight ? lightSettingsListBackground : darkSettingsListBackground;

  final sectionBackground = isLight ? lightSettingSectionColor : darkSettingSectionColor;

  final titleTextColor = isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

  final settingsTileTextColor = isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

  final dividerColor = isLight ? lightDividerColor : darkDividerColor;

  final trailingTextColor = isLight ? lightTrailingTextColor : darkTrailingTextColor;

  final tileHighlightColor = isLight ? lightTileHighlightColor : darkTileHighlightColor;

  final leadingIconsColor = isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

  return SettingsThemeData(
    tileHighlightColor: tileHighlightColor,
    settingsListBackground: listBackground,
    settingsSectionBackground: sectionBackground,
    titleTextColor: titleTextColor,
    dividerColor: dividerColor,
    trailingTextColor: trailingTextColor,
    settingsTileTextColor: settingsTileTextColor,
    leadingIconsColor: leadingIconsColor,
    inactiveTitleColor: CupertinoColors.inactiveGray,
    inactiveSubtitleColor: CupertinoColors.inactiveGray,
  );
}
