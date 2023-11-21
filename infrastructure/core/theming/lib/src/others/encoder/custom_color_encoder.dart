import 'package:deps/packages/theme_tailor_annotation.dart';
import 'package:flutter/material.dart';

class CustomColorEncoder extends ThemeEncoder<Color> {
  const CustomColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}
