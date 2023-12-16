import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class PaddingTop extends StatelessWidget {
  factory PaddingTop.xxs({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xxs, key: key, child: child);
  factory PaddingTop.xs({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xs, key: key, child: child);
  factory PaddingTop.sm({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.sm, key: key, child: child);
  factory PaddingTop.md({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.md, key: key, child: child);
  factory PaddingTop.lg({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.lg, key: key, child: child);
  factory PaddingTop.xl({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xl, key: key, child: child);
  factory PaddingTop.xxl({required Widget child, Key? key}) =>
      PaddingTop._(padding: Paddings.xxl, key: key, child: child);

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
