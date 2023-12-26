import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingSymmetric extends StatelessWidget {
  factory PaddingSymmetric.xxs({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.xxs.value,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.xs({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.xs.value,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.sm({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.sm.value,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.md({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.md.value,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.lg({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.lg.value,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.xl({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.xl.value,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.xxl({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: Paddings.xxl.value,
        key: key,
        child: child,
      );

  const PaddingSymmetric._({
    required this.padding,
    required this.vertical,
    required this.horizontal,
    required this.child,
    super.key,
  });

  final double padding;
  final Widget child;
  final bool vertical;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical ? padding : 0,
        horizontal: horizontal ? padding : 0,
      ),
      child: child,
    );
  }
}
