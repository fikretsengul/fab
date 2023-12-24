import 'package:flutter/material.dart';

import '../../constants/radiuses.dart';

class RadiusVertical extends StatelessWidget {
  factory RadiusVertical.none({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.none.value, key: key, child: child);

  factory RadiusVertical.xs({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.xs.value, key: key, child: child);

  factory RadiusVertical.sm({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.sm.value, key: key, child: child);

  factory RadiusVertical.md({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.md.value, key: key, child: child);

  factory RadiusVertical.lg({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.lg.value, key: key, child: child);

  factory RadiusVertical.xl({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.xl.value, key: key, child: child);

  factory RadiusVertical.xxl({required Widget child, Key? key}) =>
      RadiusVertical._(radius: Radiuses.xxl.value, key: key, child: child);

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
