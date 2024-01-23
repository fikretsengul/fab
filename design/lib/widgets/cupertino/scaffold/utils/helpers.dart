import 'package:flutter/cupertino.dart';

import '../models/appbar_settings.dart';

TextStyle titleTextStyle(BuildContext context, AppBarSettings appBar) {
  if (appBar.title is Text && (appBar.title! as Text).style != null) {
    return (appBar.title! as Text)
        .style!
        .merge(CupertinoTheme.of(context).textTheme.navTitleTextStyle)
        .copyWith(letterSpacing: 0, inherit: false);
  } else {
    return CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(letterSpacing: 0, inherit: false);
  }
}

Border defaultBorder() {
  return const Border(
    bottom: BorderSide(
      color: Color(0x4D000000),
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

  return textPainter.size.width * 1.4;
}
