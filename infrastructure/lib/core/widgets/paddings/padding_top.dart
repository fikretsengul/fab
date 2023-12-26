import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingTop extends StatelessWidget {
  factory PaddingTop.xxs({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xxs.value, key: key, child: child);
  factory PaddingTop.xs({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xs.value, key: key, child: child);
  factory PaddingTop.sm({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.sm.value, key: key, child: child);
  factory PaddingTop.md({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.md.value, key: key, child: child);
  factory PaddingTop.lg({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.lg.value, key: key, child: child);
  factory PaddingTop.xl({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xl.value, key: key, child: child);
  factory PaddingTop.xxl({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xxl.value, key: key, child: child);

  const PaddingTop._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: child,
    );
  }
}
