import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class RadiusAll extends StatelessWidget {
  factory RadiusAll.none({required Widget child, Key? key}) =>
      RadiusAll._(radius: $.radiuses.none, key: key, child: child);
  factory RadiusAll.xs({required Widget child, Key? key}) => RadiusAll._(radius: $.radiuses.xs, key: key, child: child);
  factory RadiusAll.sm({required Widget child, Key? key}) => RadiusAll._(radius: $.radiuses.sm, key: key, child: child);
  factory RadiusAll.md({required Widget child, Key? key}) => RadiusAll._(radius: $.radiuses.md, key: key, child: child);
  factory RadiusAll.lg({required Widget child, Key? key}) => RadiusAll._(radius: $.radiuses.lg, key: key, child: child);
  factory RadiusAll.xl({required Widget child, Key? key}) => RadiusAll._(radius: $.radiuses.xl, key: key, child: child);
  factory RadiusAll.xxl({required Widget child, Key? key}) =>
      RadiusAll._(radius: $.radiuses.xxl, key: key, child: child);

  const RadiusAll._({required this.radius, required this.child, super.key});

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: child,
    );
  }
}
