// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../_core/super/super.dart';
import '../_core/definitions/gap/gap.dart';
import '../_core/definitions/gap/sliver_gap.dart';

class PaddingGap extends Gap {
  const PaddingGap(super.mainAxisExtent, {super.key, super.crossAxisExtent, super.color});

  factory PaddingGap.expand({Key? key, Color? color}) =>
      PaddingGap($.paddings.xxs, key: key, crossAxisExtent: double.infinity, color: color);

  factory PaddingGap.xxs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.xxs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.xs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.sm({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.sm, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.md({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.md, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.lg({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.lg, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.xl, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xxl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap($.paddings.xxl, key: key, crossAxisExtent: crossAxisExtent, color: color);
}

class PaddingMaxGap extends MaxGap {
  const PaddingMaxGap(super.mainAxisExtent, {super.key, super.crossAxisExtent, super.color});

  factory PaddingMaxGap.expand({Key? key, Color? color}) =>
      PaddingMaxGap($.paddings.xxs, key: key, crossAxisExtent: double.infinity, color: color);

  factory PaddingMaxGap.xxs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.xxs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.xs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.sm({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.sm, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.md({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.md, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.lg({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.lg, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.xl, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xxl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap($.paddings.xxl, key: key, crossAxisExtent: crossAxisExtent, color: color);
}

class PaddingSliverGap extends SliverGap {
  const PaddingSliverGap(super.mainAxisExtent, {super.key, super.color});

  factory PaddingSliverGap.xxs({Key? key, Color? color}) => PaddingSliverGap($.paddings.xxs, key: key, color: color);

  factory PaddingSliverGap.xs({Key? key, Color? color}) => PaddingSliverGap($.paddings.xs, key: key, color: color);

  factory PaddingSliverGap.sm({Key? key, Color? color}) => PaddingSliverGap($.paddings.sm, key: key, color: color);

  factory PaddingSliverGap.md({Key? key, Color? color}) => PaddingSliverGap($.paddings.md, key: key, color: color);

  factory PaddingSliverGap.lg({Key? key, Color? color}) => PaddingSliverGap($.paddings.lg, key: key, color: color);

  factory PaddingSliverGap.xl({Key? key, Color? color}) => PaddingSliverGap($.paddings.xl, key: key, color: color);

  factory PaddingSliverGap.xxl({Key? key, Color? color}) => PaddingSliverGap($.paddings.xxl, key: key, color: color);
}
