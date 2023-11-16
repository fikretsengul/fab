import 'package:flutter/material.dart';

import '../../constants/fonts.gen.dart';
import '../../constants/theme_settings.dart';
import 'fab_button.dart';

/// A text button styled as per the Floating Action Button (FAB) design.
///
/// This button extends the functionalities of [FabButton] to include text-specific features,
/// such as text style customization.
class FabTextButton extends FabButton {
  /// Creates a FAB styled text button.
  ///
  /// The [text] parameter is required and specifies the text to display on the button.
  /// The [textStyle] parameter allows for custom styling of the text.
  /// All other parameters are inherited from [FabButton] and control the button's appearance and behavior.
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
    super.shadowBlurRadius,
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
  ///
  /// The style is determined by the [buttonType] and uses the appropriate color scheme
  /// from the provided [BuildContext].
  static TextStyle _defaultTextStyle({required BuildContext context, required ButtonType buttonType}) {
    final theme = Theme.of(context);
    final color = buttonType == ButtonType.primary ? theme.colorScheme.onPrimary : theme.colorScheme.onBackground;

    return TextStyle(
      color: color,
      fontFamily: FontFamily.iBMPlexMono, // Specific font family
      // Additional default styles can be added here
    );
  }
}
