// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class PaddingTop extends StatelessWidget {
  factory PaddingTop.xxs({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.xxs, key: key, child: child);
  factory PaddingTop.xs({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.xs, key: key, child: child);
  factory PaddingTop.sm({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.sm, key: key, child: child);
  factory PaddingTop.md({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.md, key: key, child: child);
  factory PaddingTop.lg({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.lg, key: key, child: child);
  factory PaddingTop.xl({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.xl, key: key, child: child);
  factory PaddingTop.xxl({required Widget child, Key? key}) =>
      PaddingTop._(padding: $.paddings.xxl, key: key, child: child);

  const PaddingTop._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: child,
    );
  }
}
