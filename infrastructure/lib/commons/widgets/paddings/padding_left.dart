import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingLeft extends StatelessWidget {
  factory PaddingLeft.xxs({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.xxs, key: key, child: child);
  factory PaddingLeft.xs({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.xs, key: key, child: child);
  factory PaddingLeft.sm({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.sm, key: key, child: child);
  factory PaddingLeft.md({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.md, key: key, child: child);
  factory PaddingLeft.lg({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.lg, key: key, child: child);
  factory PaddingLeft.xl({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.xl, key: key, child: child);
  factory PaddingLeft.xxl({required Widget child, Key? key}) =>
      PaddingLeft._(padding: Paddings.xxl, key: key, child: child);

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
