import 'package:deps/features/features.dart';
import 'package:flutter/material.dart';

class FabAppBarToolbarSettings {
  FabAppBarToolbarSettings({
    this.child = const Nil(),
    this.height = 36,
    this.enabled = false,
    this.color = Colors.transparent,
  });

  Widget child;
  final Color color;
  final bool enabled;
  double height;
}
