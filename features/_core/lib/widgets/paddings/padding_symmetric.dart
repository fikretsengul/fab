// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class PaddingSymmetric extends StatelessWidget {
  factory PaddingSymmetric.xxs({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.xxs,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.xs({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.xs,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.sm({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.sm,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.md({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.md,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.lg({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.lg,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.xl({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.xl,
        key: key,
        child: child,
      );
  factory PaddingSymmetric.xxl({
    required Widget child,
    bool vertical = false,
    bool horizontal = false,
    Key? key,
  }) =>
      PaddingSymmetric._(
        vertical: vertical,
        horizontal: horizontal,
        padding: $.paddings.xxl,
        key: key,
        child: child,
      );

  const PaddingSymmetric._({
    required this.padding,
    required this.vertical,
    required this.horizontal,
    required this.child,
    super.key,
  });

  final double padding;
  final Widget child;
  final bool vertical;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical ? padding : 0,
        horizontal: horizontal ? padding : 0,
      ),
      child: child,
    );
  }
}
