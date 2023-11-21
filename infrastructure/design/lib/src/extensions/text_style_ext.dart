import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle get mostThick => copyWith(fontWeight: FontWeight.w900);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle changeSize(double size) => copyWith(fontSize: size);
  TextStyle changeFamily(String family) => copyWith(fontFamily: family);
  TextStyle changeLetterSpacing(double space) => copyWith(letterSpacing: space);
  TextStyle changeWordSpacing(double space) => copyWith(wordSpacing: space);
  TextStyle changeColor(Color color) => copyWith(color: color);
  TextStyle changeBaseline(TextBaseline textBaseline) => copyWith(textBaseline: textBaseline);
}
