import 'package:flutter/cupertino.dart';

import '../../../_core/constants/fab_theme.dart';
import '../models/fab_appbar_settings.dart';

// SpecialColor to remove CupertinoSliverNavigationBar blur effect
class SpecialColor extends Color {
  const SpecialColor() : super(0x00000000);

  @override
  int get alpha => 0xFF;
}

TextStyle defaultTitleTextStyle(BuildContext context, FabAppBarSettings appBar) {
  if (appBar.title is Text && (appBar.title! as Text).style != null) {
    return (appBar.title! as Text).style!.copyWith(inherit: false);
  } else {
    return context.fabTheme.appBarTitleStyle.copyWith(inherit: false);
  }
}

BoxDecoration defaultBorder(BuildContext context, double value) {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: context.fabTheme.borderColor.withOpacity(value),
        width: 0,
      ),
    ),
  );
}

double defaultTextSize(String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size.width * 1.1;
}
