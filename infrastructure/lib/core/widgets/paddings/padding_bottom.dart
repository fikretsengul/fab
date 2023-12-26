import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingBottom extends StatelessWidget {
  factory PaddingBottom.xxs({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xxs.value, key: key, child: child);
  factory PaddingBottom.xs({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xs.value, key: key, child: child);
  factory PaddingBottom.sm({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.sm.value, key: key, child: child);
  factory PaddingBottom.md({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.md.value, key: key, child: child);
  factory PaddingBottom.lg({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.lg.value, key: key, child: child);
  factory PaddingBottom.xl({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xl.value, key: key, child: child);
  factory PaddingBottom.xxl({required Widget child, Key? key}) =>
      PaddingBottom._(padding: Paddings.xxl.value, key: key, child: child);

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
