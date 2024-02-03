import 'package:flutter/material.dart';

class FabAppBarLargeTitleSettings {
  FabAppBarLargeTitleSettings({
    this.largeTitle = 'Large Title',
    this.actions,
    this.textStyle,
    this.height = 52.0,
    this.padding = const EdgeInsets.only(left: 14, right: 16),
    this.enabled = true,
  });

  final List<Widget>? actions;
  final bool enabled;
  double height;
  final String largeTitle;
  final EdgeInsets padding;
  final TextStyle? textStyle;
}
