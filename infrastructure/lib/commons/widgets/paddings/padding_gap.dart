import 'package:flutter/material.dart';

import '../../constants/paddings.dart';
import '../../others/gap/gap.dart';
import '../../others/gap/sliver_gap.dart';

class PaddingGap extends Gap {
  const PaddingGap(super.mainAxisExtent, {super.key, super.crossAxisExtent, super.color});

  factory PaddingGap.expand({Key? key, Color? color}) =>
      PaddingGap(Paddings.xxs.value, key: key, crossAxisExtent: double.infinity, color: color);

  factory PaddingGap.xxs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xxs.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xs.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.sm({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.sm.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.md({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.md.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.lg({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.lg.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xl.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingGap.xxl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingGap(Paddings.xxl.value, key: key, crossAxisExtent: crossAxisExtent, color: color);
}

class PaddingMaxGap extends MaxGap {
  const PaddingMaxGap(super.mainAxisExtent, {super.key, super.crossAxisExtent, super.color});

  factory PaddingMaxGap.expand({Key? key, Color? color}) =>
      PaddingMaxGap(Paddings.xxs.value, key: key, crossAxisExtent: double.infinity, color: color);

  factory PaddingMaxGap.xxs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xxs.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xs({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xs.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.sm({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.sm.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.md({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.md.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.lg({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.lg.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xl.value, key: key, crossAxisExtent: crossAxisExtent, color: color);

  factory PaddingMaxGap.xxl({Key? key, double? crossAxisExtent, Color? color}) =>
      PaddingMaxGap(Paddings.xxl.value, key: key, crossAxisExtent: crossAxisExtent, color: color);
}

class PaddingSliverGap extends SliverGap {
  const PaddingSliverGap(super.mainAxisExtent, {super.key, super.color});

  factory PaddingSliverGap.xxs({Key? key, Color? color}) =>
      PaddingSliverGap(Paddings.xxs.value, key: key, color: color);

  factory PaddingSliverGap.xs({Key? key, Color? color}) => PaddingSliverGap(Paddings.xs.value, key: key, color: color);

  factory PaddingSliverGap.sm({Key? key, Color? color}) => PaddingSliverGap(Paddings.sm.value, key: key, color: color);

  factory PaddingSliverGap.md({Key? key, Color? color}) => PaddingSliverGap(Paddings.md.value, key: key, color: color);

  factory PaddingSliverGap.lg({Key? key, Color? color}) => PaddingSliverGap(Paddings.lg.value, key: key, color: color);

  factory PaddingSliverGap.xl({Key? key, Color? color}) => PaddingSliverGap(Paddings.xl.value, key: key, color: color);

  factory PaddingSliverGap.xxl({Key? key, Color? color}) =>
      PaddingSliverGap(Paddings.xxl.value, key: key, color: color);
}
