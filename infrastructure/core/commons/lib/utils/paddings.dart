import 'package:flutter/material.dart';

import '../widgets.dart';
import '../widgets/sliver_gap.dart';

enum Paddings {
  /// 4px
  xxs._(4),

  /// 8px
  xs._(8),

  /// 12px
  sm._(12),

  /// 16px
  md._(16),

  // 24px
  lg._(24),

  // 32px
  xl._(32),

  // 40px
  xxl._(40);

  const Paddings._(this.value);
  final double value;
}

extension PaddingsExt on Paddings {
  EdgeInsets only({
    bool l = false,
    bool r = false,
    bool t = false,
    bool b = false,
  }) =>
      EdgeInsets.fromLTRB(
        l ? value : 0,
        t ? value : 0,
        r ? value : 0,
        b ? value : 0,
      );
  EdgeInsets get left => EdgeInsets.only(left: value);
  EdgeInsets get right => EdgeInsets.only(right: value);
  EdgeInsets get top => EdgeInsets.only(top: value);
  EdgeInsets get bottom => EdgeInsets.only(bottom: value);
  EdgeInsets get all => EdgeInsets.all(value);
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: value);
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: value);
  EdgeInsets get symmetric => EdgeInsets.all(value);

  // ignore: avoid_returning_widgets
  Widget get gap => Gap(value);

  // ignore: avoid_returning_widgets
  Widget get sliverGap => SliverGap(value);
}
