import 'package:deps/design/design.dart';
import 'package:flutter/material.dart';

/// Flutter doesn't have a direct line-height property like in CSS
/// or Figma. Instead, it uses height. The height in Flutter is the
/// multiplier applied to the font size to get the height of the line.
/// To convert the line height from Figma to Flutter use this formula:
/// Flutter height = Figma line height / Figma font size

@immutable
final class Typographs {
  const Typographs._();

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontFamily: FontFamily.tTRamillasTrial,
  );

  static const TextStyle body = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.arial,
  );
}
