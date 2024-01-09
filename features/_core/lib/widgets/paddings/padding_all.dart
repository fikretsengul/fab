// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../_core/super/super.dart';

class PaddingAll extends StatelessWidget {
  factory PaddingAll.xxs({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.xxs, key: key, child: child);
  factory PaddingAll.xs({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.xs, key: key, child: child);
  factory PaddingAll.sm({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.sm, key: key, child: child);
  factory PaddingAll.md({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.md, key: key, child: child);
  factory PaddingAll.lg({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.lg, key: key, child: child);
  factory PaddingAll.xl({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.xl, key: key, child: child);
  factory PaddingAll.xxl({required Widget child, Key? key}) =>
      PaddingAll._(padding: $.paddings.xxl, key: key, child: child);

  const PaddingAll._({required this.padding, required this.child, super.key});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
