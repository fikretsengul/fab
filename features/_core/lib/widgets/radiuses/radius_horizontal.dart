import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class RadiusHorizontal extends StatelessWidget {
  factory RadiusHorizontal.none({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.none, key: key, child: child);

  factory RadiusHorizontal.xs({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.xs, key: key, child: child);

  factory RadiusHorizontal.sm({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.sm, key: key, child: child);

  factory RadiusHorizontal.md({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.md, key: key, child: child);

  factory RadiusHorizontal.lg({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.lg, key: key, child: child);

  factory RadiusHorizontal.xl({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.xl, key: key, child: child);

  factory RadiusHorizontal.xxl({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: $.radiuses.xxl, key: key, child: child);

  const RadiusHorizontal._({required this.radius, required this.child, super.key});

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(radius),
          right: Radius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}
