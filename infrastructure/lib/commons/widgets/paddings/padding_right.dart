import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingRight extends StatelessWidget {
  factory PaddingRight.xxs({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xxs.value, key: key, child: child);
  factory PaddingRight.xs({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xs.value, key: key, child: child);
  factory PaddingRight.sm({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.sm.value, key: key, child: child);
  factory PaddingRight.md({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.md.value, key: key, child: child);
  factory PaddingRight.lg({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.lg.value, key: key, child: child);
  factory PaddingRight.xl({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xl.value, key: key, child: child);
  factory PaddingRight.xxl({required Widget child, Key? key}) =>
      PaddingRight._(padding: Paddings.xxl.value, key: key, child: child);

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
