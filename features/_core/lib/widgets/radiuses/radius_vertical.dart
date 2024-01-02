import 'package:flutter/material.dart';

import '../../super/super.dart';

class RadiusVertical extends StatelessWidget {
  factory RadiusVertical.none({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.none, key: key, child: child);

  factory RadiusVertical.xs({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.xs, key: key, child: child);

  factory RadiusVertical.sm({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.sm, key: key, child: child);

  factory RadiusVertical.md({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.md, key: key, child: child);

  factory RadiusVertical.lg({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.lg, key: key, child: child);

  factory RadiusVertical.xl({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.xl, key: key, child: child);

  factory RadiusVertical.xxl({required Widget child, Key? key}) =>
      RadiusVertical._(radius: $.radiuses.xxl, key: key, child: child);

  const RadiusVertical._({required this.radius, required this.child, super.key});

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
          bottom: Radius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}
