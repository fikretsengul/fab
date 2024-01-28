import 'package:flutter/material.dart';

class AppBarBottomSettings {
  AppBarBottomSettings({
    this.child = const SizedBox(),
    this.height = 38,
    this.enabled = false,
    this.color = Colors.transparent,
  });

  Widget child;
  final Color color;
  final bool enabled;
  double height;
}
