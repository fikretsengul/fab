import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingAll extends StatelessWidget {
  factory PaddingAll.xxs({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xxs.value, key: key, child: child);
  factory PaddingAll.xs({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xs.value, key: key, child: child);
  factory PaddingAll.sm({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.sm.value, key: key, child: child);
  factory PaddingAll.md({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.md.value, key: key, child: child);
  factory PaddingAll.lg({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.lg.value, key: key, child: child);
  factory PaddingAll.xl({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xl.value, key: key, child: child);
  factory PaddingAll.xxl({required Widget child, Key? key}) =>
      PaddingAll._(padding: Paddings.xxl.value, key: key, child: child);

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
