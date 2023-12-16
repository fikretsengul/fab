import 'package:flutter/material.dart';

import '../../constants/paddings.dart';
import '../../constants/radiuses.dart';

class RadiusHorizontal extends StatelessWidget {
  factory RadiusHorizontal.none({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Radiuses.none, key: key, child: child);

  factory RadiusHorizontal.xs({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Radiuses.xs, key: key, child: child);

  factory RadiusHorizontal.sm({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Radiuses.sm, key: key, child: child);

  factory RadiusHorizontal.md({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Radiuses.md, key: key, child: child);

  factory RadiusHorizontal.lg({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Radiuses.lg, key: key, child: child);

  factory RadiusHorizontal.xl({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Radiuses.xl, key: key, child: child);

  factory RadiusHorizontal.xxl({required Widget child, Key? key}) =>
      RadiusHorizontal._(radius: Paddings.xxl, key: key, child: child);

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
