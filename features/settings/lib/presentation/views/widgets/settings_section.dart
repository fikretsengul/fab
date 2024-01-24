// ignore_for_file: deprecated_member_use, avoid_returning_widgets

import 'package:flutter/material.dart';

import 'settings_theme.dart';
import 'settings_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.tiles,
    required this.title,
    super.key,
  });

  final List<SettingsTile> tiles;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 16,
              bottom: 6,
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                color: theme.themeData.titleTextColor,
                fontSize: 13,
              ),
              child: title!,
            ),
          ),
        buildTileList(),
      ],
    );
  }

  Widget buildTileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final tile = tiles[index];

        var shouldEnableTop = false;

        if (index == 0 || (index > 0 && tiles[index - 1].description != null)) {
          shouldEnableTop = true;
        }

        var shouldEnableBottom = false;

        if (index == tiles.length - 1 || (index < tiles.length && tile.description != null)) {
          shouldEnableBottom = true;
        }

        return SettingsTileAdditionalInfo(
          enableTopBorderRadius: shouldEnableTop,
          enableBottomBorderRadius: shouldEnableBottom,
          needToShowDivider: index != tiles.length - 1,
          child: tile,
        );
      },
    );
  }
}
