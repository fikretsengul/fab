import 'package:deps/features/features.dart';
import 'package:flutter/material.dart';

class FabAppBarToolbarSettings {
  FabAppBarToolbarSettings({
    this.child = const Nil(),
    this.height = 40,
    this.enabled = false,
    this.padding = const EdgeInsets.only(bottom: 8),
    this.color = Colors.transparent,
  });

  final Widget child;
  final Color color;
  final bool enabled;
  final EdgeInsets padding;
  double height;
}
