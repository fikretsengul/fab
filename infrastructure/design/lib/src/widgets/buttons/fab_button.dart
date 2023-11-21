// ignore_for_file: max_lines_for_file

import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../../design.dart';

/// A customizable floating action button (FabButton) that exhibits a press animation.
///
/// This button allows for extensive customization including colors, border, shadow, and animation.
/// It takes a [child] widget which is typically an Icon or Text widget.
class FabButton extends StatefulWidget {
  FabButton({
    required this.child,
    this.animated = true,
    super.key,
    this.buttonColor,
    this.shadowColor,
    this.borderColor,
    this.onPressed,
    this.buttonType = ButtonType.primary,
    this.borderRadius = ThemeSettings.borderRadius,
    this.offset = ThemeSettings.offset,
    this.buttonHeight,
    this.buttonWidth,
    this.padding,
    this.borderWidth = ThemeSettings.borderWidth,
    this.animationDuration = 100,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Whether the button should animate on press.
  final bool animated;

  /// The color of the button, defaults to theme's primary color.
  final Color? buttonColor;

  /// The color of the button's shadow.
  final Color? shadowColor;

  /// The color of the button's border.
  final Color? borderColor;

  /// The callback that is called when the button is tapped.
  final GestureTapCallback? onPressed;

  /// The type of the button which defines its base color.
  final ButtonType buttonType;

  /// The radius of the border's corners.
  final double? borderRadius;

  /// The offset for the button's shadow.
  final Offset offset;

  /// The height of the button.
  final double? buttonHeight;

  /// The width of the button, if not set the button wraps its content.
  final double? buttonWidth;

  /// The internal padding for the button's child.
  final EdgeInsets? padding;

  /// The width of the button's border.
  final double borderWidth;

  /// The duration of the animation when the button is pressed.
  final int animationDuration;

  /// Whether the button is enabled or not. Derived from the onPressed callback.
  /// If onPressed is null, the button is considered disabled.
  bool get isEnabled => onPressed != null;

  @override
  State<FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller and animation for press effects.
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    )..addListener(() {
        setState(() {});
      });

    // Define the animation with a curve to simulate a bouncing effect.
    _animation = Tween<Offset>(begin: Offset.zero, end: widget.offset).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller to release resources.
    _controller.dispose();
    super.dispose();
  }

  void _onTapCancel() {
    // Reset animation and trigger action on tap cancel.
    _resetAnimation();
  }

  void _onTapDown(TapDownDetails details) {
    // Start the animation on tap down if animation is enabled.
    if (widget.animated) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    // Reset animation and trigger action on tap up.
    _resetAnimation();
    widget.onPressed?.call();
  }

  void _resetAnimation() {
    // Reverse the animation if enabled, and call the onPressed callback if provided.
    if (widget.animated) {
      _controller.reverse();
    }
  }

  Color _getButtonColor() {
    // Determine the button color based on the button type.
    late Color color;

    switch (widget.buttonType) {
      case ButtonType.primary:
        color = context.theme.colorScheme.primary;
      default:
        color = context.theme.colorScheme.background;
    }

    // Determine the button's current color based on its enabled state.
    if (!widget.isEnabled) {
      // Return a dimmed color when the button is disabled.
      // Dim the color by blending it with grey if the button is disabled.
      return color.withRed(200).withGreen(200).withBlue(200);
    }

    return widget.buttonColor ?? color;
  }

  @override
  Widget build(BuildContext context) {
    // Build the button with gesture detection and animated press effect.
    return GestureDetector(
      onTapDown: widget.isEnabled ? _onTapDown : null,
      onTapUp: widget.isEnabled ? _onTapUp : null,
      onTapCancel: widget.isEnabled ? _onTapCancel : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          // Apply a translation transformation to create the press effect.
          return Transform.translate(
            offset: _animation.value,
            child: child,
          );
        },
        child: IntrinsicWidth(
          // Use IntrinsicWidth to size the button width to its child if width is not provided.
          child: FabContainer(
            // FabContainer is a custom container widget used here to apply styling.
            width: widget.buttonWidth,
            height: widget.buttonHeight,
            padding: widget.padding ?? EdgeInsets.symmetric(horizontal: Paddings.sm.value, vertical: Paddings.xs.value),
            borderRadius: widget.borderRadius,
            color: widget.buttonColor ?? _getButtonColor(),
            borderColor: widget.borderColor ??
                (widget.buttonType == ButtonType.primary
                    ? context.theme.colorScheme.primary
                    : context.theme.colorScheme.onBackground),
            borderWidth: widget.borderWidth,
            shadowColor: widget.shadowColor ?? context.theme.colorScheme.onBackground,
            offset: widget.offset - _animation.value, // Adjust offset for the shadow
            child: Center(child: widget.child), // Center the button's child.
          ),
        ),
      ),
    );
  }
}
