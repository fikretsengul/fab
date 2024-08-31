import 'package:flutter/material.dart';

class FabAppBarLargeTitleSettings {
  FabAppBarLargeTitleSettings({
    this.text = 'Large Title',
    this.actions,
    this.textStyle,
    this.height = 50,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.enabled = false,
  });

  final List<Widget>? actions;
  final bool enabled;
  double height;
  final String text;
  final EdgeInsets padding;
  final TextStyle? textStyle;
}
