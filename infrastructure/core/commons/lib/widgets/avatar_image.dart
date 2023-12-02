// ignore_for_file: max_lines_for_file
import 'package:flutter/material.dart';

import '../utils.dart';

class AvatarImage extends StatelessWidget {
  /// Create Avatar of all types i,e, square, circle, standard with different sizes.
  const AvatarImage({
    super.key,
    this.child,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.borderRadius,
    this.shape = AvatarImageShape.circle,
    this.size = ImageSize.medium,
  }) : assert(radius == null || (minRadius == null && maxRadius == null));

  /// Typically a [Text] widget. If the [CircleAvatar] is to have an image, use [backgroundImage] instead.
  final Widget? child;

  final Color? backgroundColor;

  /// use [Color] The default text color for text in the circle.
  final Color? foregroundColor;

  /// The background image of the circle.
  final ImageProvider? backgroundImage;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double? radius;

  /// The minimum size of the avatar, expressed as the radius (half the diameter).
  final double? minRadius;

  /// The maximum size of the avatar, expressed as the radius (half the diameter).
  final double? maxRadius;

  /// size of avatar. use [ImageSize] or [ImageSize] i.e, 1.2, small, medium, large etc.
  final double size;

  /// shape of avatar [AvatarImageShape] i.e, standard, circle, square
  final AvatarImageShape shape;

  /// border radius to give extra radius for avatar square or standard shape
  /// Not applicable to circle shape
  final BorderRadius? borderRadius;

  // /// The default max if only the min is specified.
  // static const double _defaultMaxRadius = double.infinity;

  double get _minDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return 1.5 * size;
    } else {
      return 2.0 * (radius ?? minRadius ?? 0);
    }
  }

  double get _maxDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return 1.5 * size;
    } else {
      return 2.0 * (radius ?? maxRadius ?? 0);
    }
  }

  BoxShape get _avatarShape {
    if (shape == AvatarImageShape.circle) {
      return BoxShape.circle;
    } else if (shape == AvatarImageShape.square) {
      return BoxShape.rectangle;
    } else if (shape == AvatarImageShape.standard) {
      return BoxShape.rectangle;
    } else {
      return BoxShape.rectangle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    assert(debugCheckHasMediaQuery(context));
    final theme = Theme.of(context);
    var textStyle = theme.primaryTextTheme.titleMedium?.copyWith(
      color: foregroundColor,
    );
    var effectiveBackgroundColor = backgroundColor;

    if (effectiveBackgroundColor == null && textStyle?.color != null) {
      switch (ThemeData.estimateBrightnessForColor(textStyle!.color!)) {
        case Brightness.dark:
          effectiveBackgroundColor = theme.primaryColorLight;
        case Brightness.light:
          effectiveBackgroundColor = theme.primaryColorDark;
      }
    } else if (foregroundColor == null && textStyle != null) {
      switch (ThemeData.estimateBrightnessForColor(backgroundColor!)) {
        case Brightness.dark:
          textStyle = textStyle.copyWith(color: theme.primaryColorLight);
        case Brightness.light:
          textStyle = textStyle.copyWith(color: theme.primaryColorDark);
      }
    }
    final minDiameter = _minDiameter;
    final maxDiameter = _maxDiameter;

    return AnimatedContainer(
      constraints: BoxConstraints(
        minHeight: minDiameter,
        minWidth: minDiameter,
        maxWidth: maxDiameter,
        maxHeight: maxDiameter,
      ),
      duration: kThemeChangeDuration,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
              )
            : null,
        shape: _avatarShape,
        borderRadius:
            shape == AvatarImageShape.standard && borderRadius == null ? Radiuses.md.circularBorder : borderRadius,
      ),
      child: child == null && textStyle != null
          ? null
          : Center(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                child: IconTheme(
                  data: theme.iconTheme.copyWith(color: textStyle?.color),
                  child: DefaultTextStyle(
                    style: textStyle!,
                    child: child!,
                  ),
                ),
              ),
            ),
    );
  }
}

/// [AvatarImageShape] is used to shape the AvatarImage widget.
enum AvatarImageShape { circle, standard, square }

/// [ImageSize] is used to change the size of the widget.
class ImageSize {
  static const double small = 30;
  static const double medium = 35;
  static const double large = 40;
}
