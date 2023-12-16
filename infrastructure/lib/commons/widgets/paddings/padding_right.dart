import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingRight extends StatelessWidget {
  factory PaddingRight.xxs({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xxs, key: key, child: child);
  factory PaddingRight.xs({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xs, key: key, child: child);
  factory PaddingRight.sm({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.sm, key: key, child: child);
  factory PaddingRight.md({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.md, key: key, child: child);
  factory PaddingRight.lg({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.lg, key: key, child: child);
  factory PaddingRight.xl({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xl, key: key, child: child);
  factory PaddingRight.xxl({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xxl, key: key, child: child);

  const PaddingRight._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: padding),
      child: child,
    );
  }
}
