import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_settings.dart';
import 'fab_button.dart';

/// A specialized version of FabButton that uses an icon as its child.
class FabIconButton extends FabButton {
  FabIconButton({
    required this.icon,
    super.animated,
    super.key,
    this.size = 10,
    super.animationDuration,
    super.borderColor,
    super.borderRadius,
    super.buttonType,
    super.borderWidth,
    super.buttonColor,
    super.buttonHeight = 30,
    super.buttonWidth = 30,
    super.offset,
    super.onPressed,
    super.shadowBlurRadius,
    super.shadowColor,
  }) : super(
          child: Builder(
            builder: (context) {
              final textColor = _getIconColor(context, buttonType);

              return Icon(
                icon,
                color: textColor,
                size: size,
              );
            },
          ),
          padding: EdgeInsets.zero,
        );

  /// The icon to display inside the button.
  final IconData icon;

  /// The size of the icon.
  final double size;

  /// Determines the color of the icon based on the button type.
  static Color _getIconColor(BuildContext context, ButtonType buttonType) {
    return switch (buttonType) {
      ButtonType.primary => context.theme.colorScheme.onPrimary,
      _ => context.theme.colorScheme.onBackground,
    };
  }
}
