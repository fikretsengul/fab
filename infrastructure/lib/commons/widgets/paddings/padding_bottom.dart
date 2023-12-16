import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingBottom extends StatelessWidget {
  factory PaddingBottom.xxs({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xxs, key: key, child: child);
  factory PaddingBottom.xs({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xs, key: key, child: child);
  factory PaddingBottom.sm({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.sm, key: key, child: child);
  factory PaddingBottom.md({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.md, key: key, child: child);
  factory PaddingBottom.lg({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.lg, key: key, child: child);
  factory PaddingBottom.xl({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xl, key: key, child: child);
  factory PaddingBottom.xxl({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xxl, key: key, child: child);

  const PaddingBottom._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: child,
    );
  }
}
