import 'package:flutter/material.dart';

import '../../constants/paddings.dart';

class RadiusVertical extends StatelessWidget {
  factory RadiusVertical.xxs({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.xxs, key: key, child: child);

  factory RadiusVertical.xs({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.xs, key: key, child: child);

  factory RadiusVertical.sm({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.sm, key: key, child: child);

  factory RadiusVertical.md({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.md, key: key, child: child);

  factory RadiusVertical.lg({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.lg, key: key, child: child);

  factory RadiusVertical.xl({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.xl, key: key, child: child);

  factory RadiusVertical.xxl({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Paddings.xxl, key: key, child: child);

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
