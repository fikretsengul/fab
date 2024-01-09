// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class PaddingOnly extends StatelessWidget {
  factory PaddingOnly.xxs({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.xxs,
        key: key,
        child: child,
      );
  factory PaddingOnly.xs({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.xs,
        key: key,
        child: child,
      );
  factory PaddingOnly.sm({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.sm,
        key: key,
        child: child,
      );
  factory PaddingOnly.md({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.md,
        key: key,
        child: child,
      );
  factory PaddingOnly.lg({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.lg,
        key: key,
        child: child,
      );
  factory PaddingOnly.xl({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.xl,
        key: key,
        child: child,
      );
  factory PaddingOnly.xxl({
    required Widget child,
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
    Key? key,
  }) =>
      PaddingOnly._(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        padding: $.paddings.xxl,
        key: key,
        child: child,
      );

  const PaddingOnly._({
    required this.padding,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.child,
    super.key,
  });

  final double padding;
  final Widget child;
  final bool left;
  final bool right;
  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ? padding : 0,
        top ? padding : 0,
        right ? padding : 0,
        bottom ? padding : 0,
      ),
      child: child,
    );
  }
}
