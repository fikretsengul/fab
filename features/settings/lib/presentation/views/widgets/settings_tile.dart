// ignore_for_file: max_lines_for_file, avoid_returning_widgets, deprecated_member_use, prefer_constructors_over_static_methods
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'settings_theme.dart';

enum SettingsTileType { simpleTile, switchTile, navigationTile }

class SettingsTile extends StatelessWidget {
  SettingsTile({
    required this.title,
    this.leading,
    this.trailing,
    this.value,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
  }) {
    onToggle = null;
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.simpleTile;
  }

  SettingsTile.navigation({
    required this.title,
    this.leading,
    this.trailing,
    this.value,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
  }) {
    onToggle = null;
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.navigationTile;
  }

  SettingsTile.switchTile({
    required this.initialValue,
    required this.onToggle,
    required this.title,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
  }) {
    value = null;
    tileType = SettingsTileType.switchTile;
  }

  /// The widget at the beginning of the tile
  final Widget? leading;

  /// The Widget at the end of the tile
  final Widget? trailing;

  /// The widget at the center of the tile
  final Widget title;

  /// The widget at the bottom of the [title]
  final Widget? description;

  /// A function that is called by tap on a tile
  final Function(BuildContext context)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(bool value)? onToggle;
  late final SettingsTileType tileType;
  late final bool? initialValue;
  late final bool enabled;

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      description: description,
      onPressed: onPressed,
      onToggle: onToggle,
      tileType: tileType,
      value: value,
      leading: leading,
      title: title,
      trailing: trailing,
      enabled: enabled,
      activeSwitchColor: activeSwitchColor,
      initialValue: initialValue ?? false,
    );
  }
}

class _SettingsTile extends StatefulWidget {
  const _SettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onToggle,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    required this.enabled,
    required this.trailing,
  });

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool? initialValue;
  final bool enabled;
  final Color? activeSwitchColor;
  final Widget? trailing;

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<_SettingsTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final additionalInfo = SettingsTileAdditionalInfo.of(context);
    final theme = SettingsTheme.of(context);

    return IgnorePointer(
      ignoring: !widget.enabled,
      child: Column(
        children: [
          _buildTitle(
            context: context,
            theme: theme,
            additionalInfo: additionalInfo,
          ),
          if (widget.description != null)
            _buildDescription(
              context: context,
              theme: theme,
              additionalInfo: additionalInfo,
            ),
        ],
      ),
    );
  }

  Widget _buildTitle({
    required BuildContext context,
    required SettingsTheme theme,
    required SettingsTileAdditionalInfo additionalInfo,
  }) {
    final content = _buildTileContent(context, theme, additionalInfo);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: additionalInfo.enableTopBorderRadius ? const Radius.circular(12) : Radius.zero,
        bottom: additionalInfo.enableBottomBorderRadius ? const Radius.circular(12) : Radius.zero,
      ),
      child: content,
    );
  }

  Widget _buildDescription({
    required BuildContext context,
    required SettingsTheme theme,
    required SettingsTileAdditionalInfo additionalInfo,
  }) {
    final scaleFactor = MediaQuery.textScaleFactorOf(context);

    return Container(
      padding: EdgeInsets.fromLTRB(16, 8 * scaleFactor, 18, additionalInfo.needToShowDivider ? 16 : 8 * scaleFactor),
      decoration: BoxDecoration(
        color: theme.themeData.settingsListBackground,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: theme.themeData.titleTextColor,
          fontSize: 13,
        ),
        child: widget.description!,
      ),
    );
  }

  Widget _buildTrailing({
    required BuildContext context,
    required SettingsTheme theme,
  }) {
    final scaleFactor = MediaQuery.textScaleFactorOf(context);

    return Row(
      children: [
        if (widget.trailing != null) widget.trailing!,
        if (widget.tileType == SettingsTileType.switchTile)
          CupertinoSwitch(
            value: widget.initialValue ?? true,
            onChanged: widget.onToggle,
            activeColor: widget.enabled ? widget.activeSwitchColor : theme.themeData.inactiveTitleColor,
          ),
        if (widget.tileType == SettingsTileType.navigationTile && widget.value != null)
          DefaultTextStyle(
            style: TextStyle(
              color: widget.enabled ? theme.themeData.trailingTextColor : theme.themeData.inactiveTitleColor,
              fontSize: 17,
            ),
            child: widget.value!,
          ),
        if (widget.tileType == SettingsTileType.navigationTile)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
            child: IconTheme(
              data: IconTheme.of(context).copyWith(color: theme.themeData.leadingIconsColor),
              child: Icon(
                CupertinoIcons.chevron_forward,
                size: 18 * scaleFactor,
              ),
            ),
          ),
      ],
    );
  }

  void _changePressState({bool isPressed = false}) {
    if (mounted) {
      setState(() {
        _isPressed = isPressed;
      });
    }
  }

  Widget _buildTileContent(
    BuildContext context,
    SettingsTheme theme,
    SettingsTileAdditionalInfo additionalInfo,
  ) {
    final scaleFactor = MediaQuery.textScaleFactorOf(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onPressed == null
          ? null
          : () {
              _changePressState(isPressed: true);

              widget.onPressed!.call(context);

              Future.delayed(
                const Duration(milliseconds: 100),
                _changePressState,
              );
            },
      onTapDown: (_) => widget.onPressed == null ? null : _changePressState(isPressed: true),
      onTapUp: (_) => widget.onPressed == null ? null : _changePressState(),
      onTapCancel: () => widget.onPressed == null ? null : _changePressState(),
      child: Container(
        color: _isPressed ? theme.themeData.tileHighlightColor : theme.themeData.settingsSectionBackground,
        padding: const EdgeInsetsDirectional.only(start: 18),
        child: Row(
          children: [
            if (widget.leading != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: widget.enabled ? theme.themeData.leadingIconsColor : theme.themeData.inactiveTitleColor,
                  ),
                  child: widget.leading!,
                ),
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 12.5 * scaleFactor,
                              bottom: 12.5 * scaleFactor,
                            ),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: widget.enabled
                                    ? theme.themeData.settingsTileTextColor
                                    : theme.themeData.inactiveTitleColor,
                                fontSize: 16,
                              ),
                              child: widget.title!,
                            ),
                          ),
                        ),
                        _buildTrailing(context: context, theme: theme),
                      ],
                    ),
                  ),
                  if (widget.description == null && additionalInfo.needToShowDivider)
                    Divider(
                      height: 0,
                      thickness: 0.7,
                      color: theme.themeData.dividerColor,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTileAdditionalInfo extends InheritedWidget {
  SettingsTileAdditionalInfo({
    required this.needToShowDivider,
    required this.enableTopBorderRadius,
    required this.enableBottomBorderRadius,
    required super.child,
    super.key,
  });
  final bool needToShowDivider;
  final bool enableTopBorderRadius;
  final bool enableBottomBorderRadius;

  @override
  bool updateShouldNotify(SettingsTileAdditionalInfo oldWidget) => true;

  static SettingsTileAdditionalInfo of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SettingsTileAdditionalInfo>();

    return result ??
        SettingsTileAdditionalInfo(
          needToShowDivider: true,
          enableBottomBorderRadius: true,
          enableTopBorderRadius: true,
          child: const SizedBox(),
        );
  }
}
