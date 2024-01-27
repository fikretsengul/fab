import 'package:flutter/cupertino.dart';

import '../../../../_core/constants/app_theme.dart';
import '../models/appbar_settings.dart';

// SpecialColor to remove CupertinoSliverNavigationBar blur effect
class SpecialColor extends Color {
  const SpecialColor() : super(0x00000000);

  @override
  int get alpha => 0xFF;
}

TextStyle defaultTitleTextStyle(BuildContext context, AppBarSettings appBar) {
  if (appBar.title is Text && (appBar.title! as Text).style != null) {
    return (appBar.title! as Text).style!.copyWith(inherit: false);
  } else {
    return context.appTheme.appBarTitleNActions.copyWith(inherit: false);
  }
}

BoxDecoration defaultBorder(double value) {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: const Color(0x4C000000).withOpacity(value),
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
