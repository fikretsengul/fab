import 'package:flutter/material.dart';

import '../../super/super.dart';

class PaddingBottom extends StatelessWidget {
  factory PaddingBottom.xxs({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.xxs, key: key, child: child);
  factory PaddingBottom.xs({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.xs, key: key, child: child);
  factory PaddingBottom.sm({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.sm, key: key, child: child);
  factory PaddingBottom.md({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.md, key: key, child: child);
  factory PaddingBottom.lg({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.lg, key: key, child: child);
  factory PaddingBottom.xl({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.xl, key: key, child: child);
  factory PaddingBottom.xxl({required Widget child, Key? key}) =>
      PaddingBottom._(padding: $.paddings.xxl, key: key, child: child);

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
