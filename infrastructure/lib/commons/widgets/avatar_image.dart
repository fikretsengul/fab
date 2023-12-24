// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'package:flutter/material.dart';

import '../constants/radiuses.dart';

/// A widget for displaying avatars, supporting various shapes and sizes.
class AvatarImage extends StatelessWidget {
  /// Create Avatar of all types i.e., square, circle, standard with different sizes.
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

  /// The background color of the avatar.
  final Color? backgroundColor;

  /// The foreground color of the avatar, used for text or icons.
  final Color? foregroundColor;

  /// The background image of the avatar.
  final ImageProvider? backgroundImage;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double? radius;

  /// The minimum size of the avatar, expressed as the radius (half the diameter).
  final double? minRadius;

  /// The maximum size of the avatar, expressed as the radius (half the diameter).
  final double? maxRadius;

  /// The size of the avatar. Use predefined [ImageSize] values or custom sizes.
  final double size;

  /// The shape of the avatar, either circle, square, or standard.
  final AvatarImageShape shape;

  /// The border radius for square or standard-shaped avatars. Not applicable to circle shape.
  final BorderRadius? borderRadius;

  double get _maxDiameter => 2.0 * (radius ?? maxRadius ?? size);

  BoxShape get _avatarShape {
    if (shape == AvatarImageShape.circle) {
      return BoxShape.circle;
    }
    return BoxShape.rectangle;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? Theme.of(context).primaryColor;

    return Container(
      width: _maxDiameter,
      height: _maxDiameter,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        image: backgroundImage != null ? DecorationImage(image: backgroundImage!, fit: BoxFit.cover) : null,
        shape: _avatarShape,
        borderRadius: shape != AvatarImageShape.circle ? borderRadius ?? Radiuses.md.circularBorder : null,
      ),
      child: child,
    );
  }
}

/// Defines the shape for the [AvatarImage] widget.
enum AvatarImageShape { circle, standard, square }

/// Predefined sizes for the [AvatarImage] widget.
class ImageSize {
  static const double small = 30;
  static const double medium = 35;
  static const double large = 40;
}
