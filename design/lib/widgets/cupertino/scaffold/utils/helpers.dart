import 'package:flutter/cupertino.dart';

import '../../../../_core/constants/app_theme.dart';
import '../models/appbar_settings.dart';

TextStyle defaultTitleTextStyle(BuildContext context, AppBarSettings appBar) {
  if (appBar.title is Text && (appBar.title! as Text).style != null) {
    return (appBar.title! as Text).style!.copyWith(inherit: false);
  } else {
    return context.appTheme.appBarTitleNActions.copyWith(inherit: false);
  }
}

Border defaultBorder() {
  return const Border(
    bottom: BorderSide(
      color: Color(0x4C000000),
      width: 0,
    ),
  );
}

double textSize(String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size.width * 1.1;
}
