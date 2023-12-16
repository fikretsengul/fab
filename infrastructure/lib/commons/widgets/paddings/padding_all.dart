import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingAll extends StatelessWidget {
  factory PaddingAll.xxs({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xxs, key: key, child: child);
  factory PaddingAll.xs({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xs, key: key, child: child);
  factory PaddingAll.sm({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.sm, key: key, child: child);
  factory PaddingAll.md({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.md, key: key, child: child);
  factory PaddingAll.lg({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.lg, key: key, child: child);
  factory PaddingAll.xl({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xl, key: key, child: child);
  factory PaddingAll.xxl({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xxl, key: key, child: child);

  const PaddingAll._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
