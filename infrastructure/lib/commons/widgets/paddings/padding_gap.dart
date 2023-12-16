import 'package:flutter/material.dart';

import '../../constants/paddings.dart';
import '../../others/gap/gap.dart';
import '../../others/gap/sliver_gap.dart';

class PaddingGap extends Gap {
  const PaddingGap(super.mainAxisExtent, {super.key, super.crossAxisExtent, super.color});

  factory PaddingGap.expand({Key? key, Color? color}) =>
      PaddingGap(Paddings.xxs, key: key, crossAxisExtent: double.infinity, color: color);

  factory PaddingGap.xxs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xxs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.sm({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.sm, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.md({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.md, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.lg({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.lg, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xl, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xxl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xxl, key: key, crossAxisExtent: crossAxisExtent, color: color);
}

class PaddingMaxGap extends MaxGap {
  const PaddingMaxGap(super.mainAxisExtent, {super.key, super.crossAxisExtent, super.color});

  factory PaddingMaxGap.expand({Key? key, Color? color}) =>
      PaddingMaxGap(Paddings.xxs, key: key, crossAxisExtent: double.infinity, color: color);

  factory PaddingMaxGap.xxs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xxs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xs, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.sm({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.sm, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.md({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.md, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.lg({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.lg, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xl, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xxl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xxl, key: key, crossAxisExtent: crossAxisExtent, color: color);
}

class PaddingSliverGap extends SliverGap {
  const PaddingSliverGap(super.mainAxisExtent, {super.key, super.color});

  factory PaddingSliverGap.xxs({Key? key, Color? color}) => PaddingSliverGap(Paddings.xxs, key: key, color: color);

  factory PaddingSliverGap.xs({Key? key, Color? color}) => PaddingSliverGap(Paddings.xs, key: key, color: color);

  factory PaddingSliverGap.sm({Key? key, Color? color}) => PaddingSliverGap(Paddings.sm, key: key, color: color);

  factory PaddingSliverGap.md({Key? key, Color? color}) => PaddingSliverGap(Paddings.md, key: key, color: color);

  factory PaddingSliverGap.lg({Key? key, Color? color}) => PaddingSliverGap(Paddings.lg, key: key, color: color);

  factory PaddingSliverGap.xl({Key? key, Color? color}) => PaddingSliverGap(Paddings.xl, key: key, color: color);

  factory PaddingSliverGap.xxl({Key? key, Color? color}) => PaddingSliverGap(Paddings.xxl, key: key, color: color);
}
