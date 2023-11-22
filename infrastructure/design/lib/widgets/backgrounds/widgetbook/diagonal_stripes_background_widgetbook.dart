import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

import '../diagonal_stripes_background.dart';

// ignore: avoid_returning_widgets
@UseCase(
  name: 'Diagonal Stripes Background',
  type: DiagonalStripesBackground,
)
Widget diagonalStripesBackground(BuildContext context) {
  return DiagonalStripesBackground(
    stripeCount: context.knobs.int.input(
      label: 'Stripe Count',
      initialValue: 20,
    ),
    stripeWidth: context.knobs.double.slider(
      label: 'Stripe Width',
      initialValue: 2,
    ),
    direction: context.knobs.list(
      label: 'Direction',
      options: DiagonalStripeDirection.values,
      labelBuilder: (o) => o.name.capitalizeFirst(),
    ),
    bgColor: context.knobs.color(
      label: 'Background Color',
      initialValue: context.background,
    ),
    fgColor: context.knobs.color(
      label: 'Foreground Color',
      initialValue: context.onBackground,
    ),
  );
}
