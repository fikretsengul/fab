import 'package:flutter/material.dart';

import '../../../design.dart';
import 'fab_button.dart';

/// A specialized version of FabButton that uses text as its child.
class FabTextButton extends FabButton {
  FabTextButton({
    required this.text,
    this.textStyle,
    super.animated,
    super.key,
    super.animationDuration,
    super.borderColor,
    super.borderRadius,
    super.buttonType = ButtonType.primary,
    super.borderWidth,
    super.buttonColor,
    super.buttonHeight,
    super.buttonWidth,
    super.offset = ThemeSettings.offset,
    super.onPressed,
    super.shadowColor,
    super.padding,
  }) : super(
          child: Builder(
            builder: (context) {
              return Text(
                text,
                style: textStyle ?? _defaultTextStyle(context: context, buttonType: buttonType),
              );
            },
          ),
        );

  /// The text to be displayed on the button.
  final String text;

  /// The style to be applied to the button's text.
  /// If null, defaults to the FAB theme's text style.
  final TextStyle? textStyle;

  /// Provides a default text style for the button text.
  static TextStyle _defaultTextStyle({required BuildContext context, required ButtonType buttonType}) {
    final theme = Theme.of(context);
    final color = buttonType == ButtonType.primary ? theme.colorScheme.onPrimary : theme.colorScheme.onBackground;

    return TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
    );
  }
}
