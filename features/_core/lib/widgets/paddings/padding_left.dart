import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class PaddingLeft extends StatelessWidget {
  factory PaddingLeft.xxs({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.xxs, key: key, child: child);
  factory PaddingLeft.xs({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.xs, key: key, child: child);
  factory PaddingLeft.sm({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.sm, key: key, child: child);
  factory PaddingLeft.md({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.md, key: key, child: child);
  factory PaddingLeft.lg({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.lg, key: key, child: child);
  factory PaddingLeft.xl({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.xl, key: key, child: child);
  factory PaddingLeft.xxl({required Widget child, Key? key}) =>
      PaddingLeft._(padding: $.paddings.xxl, key: key, child: child);

  const PaddingLeft._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: child,
    );
  }
}
