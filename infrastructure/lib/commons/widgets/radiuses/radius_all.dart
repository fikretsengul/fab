import 'package:flutter/material.dart';

import '../../constants/radiuses.dart';

class RadiusAll extends StatelessWidget {
  factory RadiusAll.none({required Widget child, Key? key}) =>
      RadiusAll._(radius: Radiuses.none, key: key, child: child);
  factory RadiusAll.xs({required Widget child, Key? key}) => RadiusAll._(radius: Radiuses.xs, key: key, child: child);
  factory RadiusAll.sm({required Widget child, Key? key}) => RadiusAll._(radius: Radiuses.sm, key: key, child: child);
  factory RadiusAll.md({required Widget child, Key? key}) => RadiusAll._(radius: Radiuses.md, key: key, child: child);
  factory RadiusAll.lg({required Widget child, Key? key}) => RadiusAll._(radius: Radiuses.lg, key: key, child: child);
  factory RadiusAll.xl({required Widget child, Key? key}) => RadiusAll._(radius: Radiuses.xl, key: key, child: child);
  factory RadiusAll.xxl({required Widget child, Key? key}) => RadiusAll._(radius: Radiuses.xxl, key: key, child: child);

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
