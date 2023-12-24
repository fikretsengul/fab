import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingOnly extends StatelessWidget {
  factory PaddingOnly.xxs({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.xxs.value,
        key: key,
        child: child,
      );
  factory PaddingOnly.xs({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.xs.value,
        key: key,
        child: child,
      );
  factory PaddingOnly.sm({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.sm.value,
        key: key,
        child: child,
      );
  factory PaddingOnly.md({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.md.value,
        key: key,
        child: child,
      );
  factory PaddingOnly.lg({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.lg.value,
        key: key,
        child: child,
      );
  factory PaddingOnly.xl({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.xl.value,
        key: key,
        child: child,
      );
  factory PaddingOnly.xxl({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: Paddings.xxl.value,
        key: key,
        child: child,
      );

  const PaddingOnly._({
    required this.padding,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.child,
    super.key,
  });

  final double padding;
  final Widget child;
  final bool left;
  final bool right;
  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ? padding : 0,
        right: right ? padding : 0,
        top: top ? padding : 0,
        bottom: bottom ? padding : 0,
      ),
      child: child,
    );
  }
}
